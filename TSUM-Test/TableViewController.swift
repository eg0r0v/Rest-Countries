//
//  TableViewController.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 28.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import UIKit
import RxSwift

class TableViewController: UIViewController {
	
	@IBOutlet weak var tableView: TableView!
	
	private let refreshControl = UIRefreshControl()
	private let disposeBag = DisposeBag()
	
	var tableViewModel: TableViewModel? {
		didSet {
			NetworkManager.shared.isOnline
				.asObservable()
				.subscribe(onNext: { [weak self] isOnline in
					switch isOnline {
					case .unknown: break
					case .reachable(_):
						if self?.presentedViewController != nil {
							self?.dismiss(animated: true, completion: nil)
						}
					case .notReachable:
						if self?.presentedViewController == nil {
							self?.presentAlert(message: "Отсутствует подключение к Интернету")
						}
					}
				}).disposed(by: disposeBag)
			
			tableViewModel?.cellViewModels
				.asObservable()
				.skip(1)
				.subscribe(onNext: { [unowned self] _ in
					self.refreshControl.endRefreshing()
					self.tableView.reloadData()
				}).disposed(by: disposeBag)
			
			tableViewModel?.errorMessage
				.asObservable()
				.skipWhile({ $0 == nil })
				.subscribe(onNext: { [unowned self] errorMessage in
					self.presentAlert(message: errorMessage!)
				}).disposed(by: disposeBag)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		
		refreshControl.attributedTitle = NSAttributedString(string: "Обновляем данные", attributes: [:])
		refreshControl.addTarget(self, action: #selector(updateViewModel), for: .valueChanged)
		
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refreshControl
		} else {
			tableView.addSubview(refreshControl)
		}
	}
	
	internal func configureViewModel(_ tableViewModel: TableViewModel) {
		self.tableViewModel = tableViewModel
	}
	
	@objc private func updateViewModel() {
		tableViewModel?.refresh()
	}
	
	private func presentAlert(message: String) {
		refreshControl.endRefreshing()
		
		let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
		
		alertController.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
			self?.dismiss(animated: true, completion: nil)
		}))
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
			self?.present(alertController, animated: true, completion: nil)
		}
	}
}

extension TableViewController: UITableViewDelegate {
	
}

extension TableViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel?.numberOfGroups() ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel?.numberOfItemsInGroup(atIndex: section) ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellViewModel: CellViewModel = tableViewModel!.itemViewModel(atIndex: indexPath.row)!
		let cellIdentifier = cellViewModel.cellClassName()
		let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
		
		cell.configureCellViewModel(cellViewModel: cellViewModel)
		
		return cell
	}
}

