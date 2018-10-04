//
//  CountryInfoCellViewModel.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 29.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class CountryInfoCellViewModel: CellViewModel {
	
	let title: String
	let value: String
	
	init(title: String, value: String) {
		self.title = title
		self.value = value
	}
	
	override func cellClassName() -> String {
		return String(describing: CountryInfoTableViewCell.self)
	}
}
