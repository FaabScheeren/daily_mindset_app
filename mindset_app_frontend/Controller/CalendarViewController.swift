//
//  CalendarViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 14/09/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit
import HorizonCalendar

class CalendarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            
            self.selectedDay = day
            self.calendarView.setContent(self.makeContent())
        }
        view.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private lazy var calendarView = CalendarView(initialContent: makeContent())
    private var selectedDay: Day?
    private lazy var calendar = Calendar(identifier: .gregorian)
    private lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar(identifier: .gregorian)
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        let selectedDay = self.selectedDay
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            
            .withInterMonthSpacing(24)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
            
            .withDayItemProvider { day in
                let isSelected = day == selectedDay
                
                return CalendarItem<DayView, Day>(
                    viewModel: day,
                    styleID: isSelected ? "Selected" : "Default",
                    buildView: { DayView(isSelectedStyle: isSelected) },
                    updateViewModel: { [weak self] dayView, day in
                        dayView.dayText = "\(day.day)"
                        
                        if let date = self?.calendar.date(from: day.components) {
                            dayView.dayAccessibilityText = self?.dayDateFormatter.string(from: date)
                        } else {
                            dayView.dayAccessibilityText = nil
                        }
                    },
                    updateHighlightState: { dayView, isHighlighted in
                        dayView.isHighlighted = isHighlighted
                })
        }
    }
}
