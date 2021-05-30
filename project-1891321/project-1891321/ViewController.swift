//
//  ViewController.swift
//  project-1891321
//
//  Created by Apple on 2021/05/26.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet weak var calendarView: FSCalendar!
    
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .vertical
        calendarView.appearance.headerTitleColor = .systemPink
        calendarView.appearance.titleWeekendColor = .red
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.locale = Locale(identifier: "ko_KR")
        
        calendarView.delegate = self
    }
}

extension ViewController {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let TodoListViewController = self.storyboard?.instantiateViewController(identifier: "TodoListViewController") as? TodoListViewController else {return}

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        TodoListViewController.title = dateFormatter.string(from: date)

//        self.present(TodoListViewController, animated: true, completion: nil)
        
    }
}
