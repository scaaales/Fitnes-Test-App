//
//  ViewController.swift
//  Fitness Test App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
	
	let tableViewModel = TableViewModel()

	@IBOutlet private weak var mainTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		setupNavigationBar()
	}
	
	private func setupNavigationBar() {
		navigationController?.navigationBar.shadowImage = UIImage()
	}

	private func setupTableView() {
		mainTableView.delegate = self
		mainTableView.dataSource = self
		mainTableView.estimatedRowHeight = 2
		mainTableView.rowHeight = UITableView.automaticDimension
		mainTableView.backgroundColor = .white
	}

}

extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.sections[section].items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = tableViewModel.sections[indexPath.section].items[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
		item.configure(cell: cell)
		
		return cell
	}
}

extension ViewController: UITableViewDelegate {
	
}

