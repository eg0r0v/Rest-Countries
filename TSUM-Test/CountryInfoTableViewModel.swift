//
//  CountryInfoTableViewModel.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 04.10.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit
import RealmSwift

class CountryInfoTableViewModel: TableViewModel {

	private(set) var currentCountry: Country
	let countryName: String
	
	init(countryName: String) {
		self.countryName = countryName
		let realm = try! Realm()
		currentCountry = realm.object(ofType: Country.self, forPrimaryKey: countryName)!
		super.init()
	}
	
	override func setup() {
		createCellViewModels()
		if !currentCountry.hasFullInformation {
			getCountryInfo()
		}
	}
	
	override func refresh() {
		getCountryInfo()
	}
	
	private func createCellViewModels() {
		var viewModelsToSet = [CellViewModel]()
		
		if let name = currentCountry.name {
			viewModelsToSet.append(CountryInfoCellViewModel(title: "Название", value: name))
		}
		
		if let code = currentCountry.code {
			viewModelsToSet.append(CountryInfoCellViewModel(title: "Международный код", value: code))
		}
		
		if let capital = currentCountry.capital {
			viewModelsToSet.append(CountryInfoCellViewModel(title: "Столица", value: capital))
		}
		viewModelsToSet.append(CountryInfoCellViewModel(title: "Количество жителей", value: "\(currentCountry.population)"))
		
		if !currentCountry.currencies.isEmpty {
			viewModelsToSet.append(CountryInfoHeaderCellViewModel(title: "Валюты в обороте"))
			for currency in currentCountry.currencies {
				guard let name = currency.name else { continue }
				viewModelsToSet.append(CountryInfoCellViewModel(title: name , value: (currency.code ?? "No code") + " - " + (currency.symbol ?? "No symbol")))
			}
		}
		
		if !currentCountry.borders.isEmpty {
			viewModelsToSet.append(CountryInfoHeaderCellViewModel(title: "Граничит с"))
			let realm = try! Realm()
			for border in currentCountry.borders {
				if let borderCountry = realm.objects(Country.self).filter({ $0.code == border }).first {
					viewModelsToSet.append(CountryInfoCellViewModel(title: borderCountry.name ?? "", value: "\(borderCountry.population)"))
				}
			}
		}
		cellViewModels.accept(viewModelsToSet)
	}
	
	private func getCountryInfo() {
		guard let name = currentCountry.name else { return }
		
		CountriesService.shared.getCountryRequest(name: name)
			.subscribe(onSuccess: { [unowned self] countryArray in
				guard let country = countryArray.first else { return }
				let realm = try! Realm()
				try! realm.write {
					self.currentCountry.capital = country.capital
					self.currentCountry.borders = country.borders
					self.currentCountry.currencies = country.currencies
				}
				self.createCellViewModels()
			}, onError: handleError)
			.disposed(by: disposeBag)
	}
}
