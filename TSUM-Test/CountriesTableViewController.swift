//
//  CountriesTableViewController.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class CountriesTableViewController: TableViewController {

	var viewModel: CountriesTableViewModel {
		return tableViewModel as! CountriesTableViewModel
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewModel(CountriesTableViewModel())
		navigationItem.title = "Страны"
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let countryModelArray = viewModel.cellViewModels.value
		if indexPath.row >= countryModelArray.count {
			viewModel.cellViewModels.accept(countryModelArray)
			return
		}
		guard let countryModel = countryModelArray[indexPath.row] as? CountryInfoCellViewModel else { return }
		
		routeToCountryInfo(countryName: countryModel.title)
	}
	
	private func routeToCountryInfo(countryName: String) {
		guard let countryInfoTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryInfoTableViewController") as? CountryInfoTableViewController else { return }
		countryInfoTableViewController.configureViewModel(CountryInfoTableViewModel(countryName: countryName))
		navigationController?.pushViewController(countryInfoTableViewController, animated: true)
	}
}
