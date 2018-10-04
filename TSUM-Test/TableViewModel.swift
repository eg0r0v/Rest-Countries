//
//  TableViewModel.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import RxSwift
import RxCocoa

class TableViewModel {
	
	var disposeBag = DisposeBag()
	
	var cellViewModels: BehaviorRelay<[CellViewModel]> = BehaviorRelay(value: [])
	var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
	
	init() {
		setup()
	}
	
	func setup() {
	
	}
	
	func refresh() {
		
	}
	
	func handleError(_ error: Error) {
		var localizedErrorMessage = error.localizedDescription
		switch error.localizedDescription {
		case "Failed to map data to JSON.": localizedErrorMessage = "Не удалось обработать ответ от сервера"
		case "The Internet connection appears to be offline.": localizedErrorMessage = "Отсутствует подключение к Интернету"
		default: break
		}
		errorMessage.accept(localizedErrorMessage)
	}
	
	func numberOfGroups() -> Int {
		return cellViewModels.value.count > 0 ? 1 : 0
	}
	
	func numberOfItemsInGroup(atIndex index: Int) -> Int {
		return index == 0 ? cellViewModels.value.count : 0
	}
	
	func itemViewModel(atIndex index: Int) -> CellViewModel? {
		guard index < cellViewModels.value.count else { return nil }
		return cellViewModels.value[index]
	}
}
