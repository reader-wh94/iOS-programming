//
//  OtherViewController.swift
//  ch10lab
//
//  Created by Jae Moon Lee on 2021/05/10.
//

import UIKit

class OtherViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var textString: String?
    var viewController: ViewController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("OtherViewController.init")
    }
    
    override func loadView() {
        super.loadView()
        print("OtherViewController.loadView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("OtherViewController.viewDidLoad")
        // Do any additional setup after loading the view.
        if let text = textString{
            textField.text = text
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("OtherViewController.viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("OtherViewController.viewWillDisappear")
        print("-------------------------------------------")
        if let vc = viewController{
            vc.textField.text = self.textField.text
        }
    }
    
    @IBAction func gotoBackAgain(_ sender: Any) {
        if let nv = navigationController{
            nv.popViewController(animated: true)
        }else{
        dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
