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
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let testCell = tableView.dequeueReusableCell(withIdentifier: CalendarHeader.reuseIdentifier, for: indexPath) as? CalendarHeader else { fatalError() }
		testCell.configure()
		return testCell
	}
}

extension ViewController: UITableViewDelegate {
	
}

extension ViewController: JTAppleCalendarViewDataSource {
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		
		guard let startDate = formatter.date(from: "2018 12 01"), let endDate = formatter.date(from: "2018 12 31") else { fatalError() }
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
		return parameters
	}
	
	
}

extension ViewController: JTAppleCalendarViewDelegate {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.reuseIdentifier, for: indexPath) as? CalendarCell else { fatalError() }
		cell.configure(text: cellState.text, isSelected: false, hasIvent: false)
		return cell
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarCell else { return }
		cell.set(selected: true)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarCell else { return }
		cell.set(selected: false)
	}
	
}

