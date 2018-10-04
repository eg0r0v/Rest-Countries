//
//  CountriesTableViewModel.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import RealmSwift

class CountriesTableViewModel: TableViewModel {
	
	override func setup() {
		super.setup()
		getCountriesList()
	}
	
	override func refresh() {
		getCountriesList()
	}
	
	func getCountriesList() {
		CountriesService.shared.getCountriesRequest()
			.subscribe(onSuccess: { countries in
				let realm = try! Realm()
				try! realm.write {
					for oldCountry in realm.objects(Country.self) {
						oldCountry.isOld = true
					}
					for country in countries {
						country.isOld = false
						realm.add(country, update: true)
					}
					realm.delete(realm.objects(Country.self).filter({ $0.isOld }))
				}
				self.createCellViewModels()
			},
					   onError: handleError)
			.disposed(by: disposeBag)
	}
	
	private func createCellViewModels() {
		
		let realm = try! Realm()
		
		let countries = realm.objects(Country.self)
		
		var viewModelsToSet = [CellViewModel]()
		for country in countries {
			guard country.canBeShownInList else { continue }
			let countryCellViewModel = CountryInfoCellViewModel(title: country.name ?? "", value: "\(country.population)")
			viewModelsToSet.append(countryCellViewModel)
		}
		cellViewModels.accept(viewModelsToSet)
	}
}
