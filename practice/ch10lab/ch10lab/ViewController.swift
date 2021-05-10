//
//  ViewController.swift
//  ch10lab
//
//  Created by mac035 on 2021/05/10.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoOtherDirectly(_ sender: Any) {
        print("gotoOtherDirectly")
    }
    @IBAction func gotoOtherWithSegue(_ sender: Any) {
        print("gotoOtherWithSegue")
        performSegue(withIdentifier: "jmlee", sender: self)
    }
    @IBAction func gotoOtherWithPresent(_ sender: Any) {
        print("gotoOtherWithPresent")
        //let vc = UIImagePickerController()
        let vc = storyboard?.instantiateViewController(identifier: "jmleeID")
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .flipHorizontal
        present(vc!, animated: true, completion: nil)
    }
    @IBAction func gotoOtherWithPush(_ sender: Any) {
        print("gotoOtherWithPush")
        let vc = storyboard?.instantiateViewController(identifier: "jmleeID")
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
    }

}

