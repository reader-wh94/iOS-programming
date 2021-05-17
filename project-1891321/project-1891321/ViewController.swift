//
//  ViewController.swift
//  project-1891321
//
//  Created by mac024 on 2021/05/17.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .vertical
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
    }
}
