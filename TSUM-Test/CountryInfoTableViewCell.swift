//
//  CountryInfoTableViewCell.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: TableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var informationLabel: UILabel!
	
	private var viewModel: CountryInfoCellViewModel {
		return cellViewModel as! CountryInfoCellViewModel
	}
	
	override func configureCellViewModel(cellViewModel: CellViewModel) {
		super.configureCellViewModel(cellViewModel: cellViewModel)
		
		titleLabel.text = viewModel.title
		informationLabel.text = viewModel.value
	}
}
