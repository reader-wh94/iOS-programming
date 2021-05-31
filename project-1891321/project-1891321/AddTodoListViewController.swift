//
//  AddTodoListViewController.swift
//  project-1891321
//
//  Created by Apple on 2021/05/27.
//

import UIKit

class AddTodoListViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    var titleStr: String = ""
}

extension AddTodoListViewController {
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        let title = titleTextField.text!
        let content = contentTextView.text ?? ""
        let item: TodoList = TodoList(title: title, content: content)
    
        list.append(item)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddTodoListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        titleTextField.text = titleStr
        // titleTextField.isUserInteractionEnabled = false
    }
}

extension AddTodoListViewController {
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
