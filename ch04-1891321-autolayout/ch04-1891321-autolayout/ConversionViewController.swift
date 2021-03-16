//
//  ConversionViewController.swift
//  ch03-1891321-convert
//
//  Created by mac027 on 2021/03/11.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fahrenheitTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    @IBAction func fahrenheitEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            if let fahrenheitValue = Double(text) {
                let celsiusValue = 5.0/9.0*(fahrenheitValue - 32.0)
                celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
            }else {
                celsiusLabel.text = "???"
            }
        }
    }
}

extension ConversionViewController {
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer) {
        fahrenheitTextField.resignFirstResponder()
    }
}

extension ConversionViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let exist = textField.text?.range(of: ".")
        let replace = string.range(of: ".")
        
        if exist != nil && replace != nil{
            return false
        }
        return true
    }
}
