//
//  ViewController.swift
//  ch09lab
//
//  Created by mac028 on 2021/04/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // image = UIImage(named: "123.jpg")
        
        let url = Bundle.main.url(forResource: "123", withExtension: "jpg")
        let data = try? Data(contentsOf: url!)
        image = UIImage(data: data!)
        
        tableView.rowHeight = 30
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
        cell.myImageView.image = image
        return cell
    }
}
