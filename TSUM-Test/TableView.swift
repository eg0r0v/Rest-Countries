//
//  TableView.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit

class TableView: UITableView {

	override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
		guard let pathForResource = Bundle.main.path(forResource: identifier, ofType: "nib"), !pathForResource.isEmpty else { return nil }
		let cellNib = UINib(nibName: identifier, bundle: Bundle.main)
		register(cellNib, forCellReuseIdentifier: identifier)
		return super.dequeueReusableCell(withIdentifier: identifier)
	}
}
