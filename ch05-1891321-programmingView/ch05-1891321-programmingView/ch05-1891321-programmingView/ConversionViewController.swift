//
//  ViewController.swift
//  ch05-1891321-programmingView
//
//  Created by mac037 on 2021/03/23.
//

import UIKit

class ConversionViewController: UIViewController {
    var fahrenheitTextField: UITextField!
    var celsiusLabel: UILabel!
    var fdegreeLabel, isLabel, cdegreeLabel: UILabel!
    var segmentedControl: UISegmentedControl!
}

extension ConversionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLabel = createLabel("is", fontSize: 36)
        isLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        isLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        fahrenheitTextField = createTextField(placeHolder: "VALUE")
        celsiusLabel = createLabel("???", fontSize: 70)
        fdegreeLabel = createLabel("degree Fahrenheit", fontSize: 36)
        cdegreeLabel = createLabel("degrees Celsius", fontSize: 36)
        
        connectVertically(views: fahrenheitTextField, fdegreeLabel, isLabel, celsiusLabel, cdegreeLabel, spacing: 8)
        connectHorizontally(views: [fahrenheitTextField, fdegreeLabel, isLabel, celsiusLabel, cdegreeLabel])
        
        fahrenheitTextField.addTarget(self, action: #selector(fahrenheitEditingChanged), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        fahrenheitTextField.delegate = self
        
        addSegmentedControl()
    }
}

extension ConversionViewController{
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer){
        fahrenheitTextField.resignFirstResponder()
    }
}

extension ConversionViewController {
    func createTextField(placeHolder: String) -> UITextField {
        let textField = UITextField(frame: CGRect())
        textField.textAlignment = .center
        textField.placeholder = placeHolder
        textField.font = UIFont(name: textField.font!.fontName, size: 70)
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        return textField
    }
}

extension ConversionViewController {
    func createLabel(_ text: String, fontSize: CGFloat) -> UILabel {
        
        let label = UILabel(frame: CGRect())
        label.text = text
        label.textColor = UIColor(red: CGFloat(0xe1)/CGFloat(256), green: CGFloat(0x58)/CGFloat(256), blue:
            CGFloat(0x29)/CGFloat(256), alpha: CGFloat(1))
        label.textAlignment = .center
        label.font = UIFont(name: label.font!.fontName, size: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        return label
    }
}

extension ConversionViewController{
    func connectVertically(views: UIView..., spacing: CGFloat){
        for i in 0..<views.count - 1{
            views[i].bottomAnchor.constraint(equalTo: views[i+1].topAnchor, constant: spacing).isActive = true
        }
    }
}

extension ConversionViewController{
    func  connectHorizontally(views: [UIView]){
        for view in views{
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
    }
}

extension ConversionViewController{
    @objc func fahrenheitEditingChanged(sender: UITextField){
        if let text = sender.text{
            if let fahrenheitValue = Double(text){
                if(segmentedControl.selectedSegmentIndex == 0){
                    let celsiusValue = 5.0/9.0*(fahrenheitValue-32.0)
                    celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                } else {
                    let celsiusValue = 9.0/5.0*fahrenheitValue + 32.0
                    celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                }
            } else{
                celsiusLabel.text = "???"
            }
        }
    }
}

extension ConversionViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let exist = textField.text?.range(of: ".")
        let replace = string.range(of: ".")
        if exist != nil && replace != nil{
            return false
        }else{
            return true
        }
    }
}

extension ConversionViewController{
    func addSegmentedControl(){
        segmentedControl = UISegmentedControl(items: ["Fahrenheit", "Celsius"])
        let font = UIFont.systemFont(ofSize: 20)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        segmentedControl.addTarget(self, action: #selector(changeDegrees), for: .valueChanged)
    }
}

extension ConversionViewController{
    @objc func changeDegrees(sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            fdegreeLabel.text = "degrees Fahrenheit"
            cdegreeLabel.text = "degrees Celsius"
        }else{
            fdegreeLabel.text = "degrees Celsius"
            cdegreeLabel.text = "degrees Fahrenheit"
        }
        fahrenheitTextField.text = ""
        celsiusLabel.text = "???"
    }
}
