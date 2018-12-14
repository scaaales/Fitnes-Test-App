//
//  CalendarHeader.swift
//  Fitness Test App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarHeader: UITableViewCell, Identifierable {
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var collectionView: JTAppleCalendarView!
	
	private let formatter = DateFormatter()

	func configure() {
		collectionView.calendarDelegate = self
		collectionView.calendarDataSource = self
		collectionView.minimumLineSpacing = 0
		collectionView.minimumInteritemSpacing = 0
		collectionView.visibleDates { [weak self] visibleDate in
			self?.setupViewsOfCalendar(from: visibleDate)
		}
		collectionView.scrollToDate(Date())
//		makeRoundedBottom(view: collectionView)
//		makeShadow()
	}
	
	private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
		guard let date = visibleDates.monthDates.first?.date else { return }
		
		formatter.dateFormat = "MMMM yyyy"
		let monthWithYear = formatter.string(from: date)
		titleLabel.text = monthWithYear
	}
	
	private func makeRoundedBottom(view: UIView) {
		let maskPath = UIBezierPath(roundedRect: view.bounds,
									 byRoundingCorners: [.bottomRight , .bottomLeft],
									 cornerRadii: CGSize(width: 15, height: 15))
		let maskLayer = CAShapeLayer()
		maskLayer.frame = bounds
		maskLayer.path = maskPath.cgPath
		view.layer.mask = maskLayer
		view.layer.masksToBounds = true
	}
	
	private func makeShadow() {
		collectionView.layer.shadowColor = UIColor.black.cgColor
		collectionView.layer.shadowOffset = CGSize(width: 10, height: 10)
		collectionView.layer.shadowOpacity = 0.7
		collectionView.layer.shadowRadius = 7
		collectionView.layer.masksToBounds = true
	}
	
	@IBAction func prevMonth(_ sender: Any) {
		 collectionView.scrollToSegment(.previous)
	}
	
	@IBAction func nextMonth(_ sender: Any) {
		 collectionView.scrollToSegment(.next)
	}
	
}

extension CalendarHeader: JTAppleCalendarViewDataSource {
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		
		guard let startDate = formatter.date(from: "2017 12 01"), let endDate = formatter.date(from: "2019 12 31") else { fatalError() }
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
		return parameters
	}
	
	
}

extension CalendarHeader: JTAppleCalendarViewDelegate {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {

	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.reuseIdentifier, for: indexPath) as? CalendarCell else { fatalError() }
		if cellState.dateBelongsTo == .thisMonth {
			cell.configure(text: cellState.text, isSelected: false, hasIvent: false)
		} else {
			cell.configureEmpty()
		}
		
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
	
	func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
		setupViewsOfCalendar(from: visibleDates)
	}
	
}

