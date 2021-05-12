//
//  UserDetailViewController.swift
//  ch10-1891321-stackView
//
//  Created by mac028 on 2021/05/06.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController{
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facilityTableView: UITableView!
    
    var user: User?
    var facilityGroup: FacilityGroup!
    var map: [String: Int] = [:]
}

extension UserDetailViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = user ?? User(random: true)
        idTextField.text = user!.id
        nameTextField.text = user!.name
        passwordTextField.text = user!.passwd
        
        for facilityName in user!.uses{
            map[facilityName] = 1
        }
        
        facilityTableView.dataSource = self
        facilityTableView.layer.borderColor = UIColor.lightGray.cgColor
        facilityTableView.layer.cornerRadius = 5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        navigationItem.title = "\(user!.name)"
    }
}

extension UserDetailViewController{
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}

extension UserDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilityGroup.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "facilityTableViewCell")!
        let facility = facilityGroup.facilitys[indexPath.row]
        
        cell.textLabel!.text = facility.name
        cell.detailTextLabel!.text = "\(facility.open):00~\(facility.close):00 \(facility.unit)hours"
        
        let allowed = UISwitch(frame: CGRect())
        allowed.addTarget(self, action: #selector(facilityAllowed), for: .valueChanged)
        cell.accessoryView = allowed
        allowed.tag = indexPath.row
        if let _ = map[facility.name] {
            allowed.isOn = true
        }
        
        return cell
    }
}

extension UserDetailViewController{
    @objc func facilityAllowed(sender: UISwitch){
        let facilityName = facilityGroup.facilitys[sender.tag].name
        map[facilityName] = sender.isOn ? 1: nil
    }
}

extension UserDetailViewController{
    override func viewWillDisappear(_ animated: Bool) {
        user!.id = idTextField.text!
        user!.name = nameTextField.text!
        user!.passwd = passwordTextField.text!
        user!.uses = Array(map.keys)
    }
}
