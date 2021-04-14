//
//  ViewController.swift
//  ch07lab
//
//  Created by mac027 on 2021/04/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var count = 0
    var timer: Timer!
    var dispatchQueue: DispatchQueue!
    var operationQueue: OperationQueue!

    override func viewDidLoad() {
        super.viewDidLoad()
            
        dispatchQueue = DispatchQueue(label: "test")      // this is a serial
        dispatchQueue = DispatchQueue(label: "test", attributes: .concurrent)
        dispatchQueue = DispatchQueue.global()
        operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        }

    
    @objc func fire(sender: Timer){
            count += 1
            
            operationQueue.addOperation {    // (6)
                let urlStrs = [
                    "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                    "https://techrecipe.co.kr/wp-content/uploads/2019/12/191213_Twitter_001.jpg"
                ]
                sleep(5)
                let url = URL(string: urlStrs[self.count % 2])!
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data:imageData)
                    }
                }
            }
            
            operationQueue.addOperation {    // (7)
                let txtStrs = [
                    "Jae Moon Lee",
                    "Hansung University"
                ]
                DispatchQueue.main.async {
                    self.messageLabel.text = txtStrs[self.count % 2]
                }
            }
        }


}

