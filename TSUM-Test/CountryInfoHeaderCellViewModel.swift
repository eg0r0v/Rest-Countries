//
//  CountryInfoHeaderCellViewModel.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 04.10.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class CountryInfoHeaderCellViewModel: CellViewModel {
	
	let title: String
	
	init(title: String) {
		self.title = title
	}
	
	override func cellClassName() -> String {
		return String(describing: CountryInfoHeaderTableViewCell.self)
	}
}
