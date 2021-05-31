//
//  CalendarViewController.swift
//  project-1891321
//
//  Created by Apple on 2021/05/28.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarDatePicker: UIDatePicker!
    @IBOutlet weak var textLabel: UILabel!
    var strDate: String = ""
}

extension CalendarViewController {
    @IBAction func calendarDatePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        strDate = dateFormatter.string(from: calendarDatePicker.date)
    }
}

extension CalendarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarDatePicker.locale = Locale(identifier: "ko_KR")
    }
}

extension CalendarViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let todo = nav.topViewController as! TodoListViewController
        todo.mainTitleString = strDate
    }
}
