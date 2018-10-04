//
//  CountryInfoHeaderTableViewCell.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 04.10.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class CountryInfoHeaderTableViewCell: TableViewCell {
	
	@IBOutlet weak var headerLabel: UILabel!
	
	private var viewModel: CountryInfoHeaderCellViewModel {
		return cellViewModel as! CountryInfoHeaderCellViewModel
	}
	
	override func configureCellViewModel(cellViewModel: CellViewModel) {
		super.configureCellViewModel(cellViewModel: cellViewModel)
		headerLabel.text = viewModel.title
	}
}
