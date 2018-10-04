//
//  CountryInfoTableViewController.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 03.10.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class CountryInfoTableViewController: TableViewController {

	private var viewModel: CountryInfoTableViewModel {
		return tableViewModel as! CountryInfoTableViewModel
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.separatorStyle = .none
    }
	
	override func configureViewModel(_ tableViewModel: TableViewModel) {
		super.configureViewModel(tableViewModel)
		title = viewModel.currentCountry.name
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let cellModel = viewModel.cellViewModels.value[indexPath.row]
		return cellModel is CountryInfoHeaderCellViewModel ? 30 : 50
	}
}
