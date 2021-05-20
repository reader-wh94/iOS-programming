//
//  ViewController.swift
//  ch10lab
//
//  Created by Jae Moon Lee on 2021/05/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("ViewController.viewDidLoad")

    }
    override func viewWillAppear(_ animated: Bool) {
        print("ViewController.viewWillAppear")
    }

    @IBAction func gotoOtherDirectly(_ sender: Any) {
        print("gotoOtherDirectly")
    }
    
    @IBAction func gotoOtherWithSegue(_ sender: Any) {
        print("gotoOtherWithSegue")
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func gotoOtherWithPresent(_ sender: Any) {
        print("gotoOtherWithPresent")
        let vc = storyboard?.instantiateViewController(identifier: "otherID") as? OtherViewController
        vc?.textString = textField.text
        vc?.viewController = self
        
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func gotoOtherWithPush(_ sender: Any) {
        print("gotoOtherWithPush")
        let vc = storyboard?.instantiateViewController(identifier: "otherID") as? OtherViewController
        vc?.textString = textField.text
        vc?.viewController = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "segue" {
            let other = segue.destination as! OtherViewController
            //other.textField.text = self.textField.text
            other.textString = textField.text
            other.viewController = self
        }
        
    }
}
