//
//  TableViewCell.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit
import RxSwift

class TableViewCell: UITableViewCell {
	
	var cellViewModel: CellViewModel?
	var disposeBag = DisposeBag()
	
	func configureCellViewModel(cellViewModel: CellViewModel) {
		self.cellViewModel = cellViewModel
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()
	}

}
