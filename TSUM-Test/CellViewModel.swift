//
//  CellViewModel.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//
import UIKit

class CellViewModel: NSObject {
	
	func cellClassName() -> String {
		return String(describing: UITableViewCell.self)
	}
}
