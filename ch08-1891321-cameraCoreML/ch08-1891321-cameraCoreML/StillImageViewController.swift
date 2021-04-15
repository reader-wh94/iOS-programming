//
//  StillImageViewController.swift
//  ch08-1891321-cameraCoreML
//
//  Created by mac032 on 2021/04/13.
//

import UIKit
import Vision
import CoreML

class StillImageViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var request: VNCoreMLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(takePicture))
        imageView.addGestureRecognizer(tapGesture)
        
        messageLabel.layer.borderWidth = 2
        messageLabel.layer.borderColor = UIColor.red.cgColor
        
        request = createCoreMLRequest(modelName: "SqueezeNet", modelExt: "mlmodelc", completionHandler: handleImageClassifier)
        
        imageView.isUserInteractionEnabled = true
    }
}
    
extension StillImageViewController{
    @objc func takePicture(sender: UITapGestureRecognizer){
            
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
            
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
            
        //UIImagePickerController이 활성화 된다
        present(imagePickerController, animated: true, completion: nil)
    }
}
    
extension StillImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // 사진을 찍은 경우 호출되는 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            
            let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
            try! handler.perform([request])
        }
        picker.dismiss(animated: true, completion: nil)
            
        // 사진 캡쳐를 취소하는 경우 호출 함수
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        }
    }
}

extension StillImageViewController{
    func createCoreMLRequest(modelName: String, modelExt: String, completionHandler: @escaping (VNRequest, Error?) -> Void) -> VNCoreMLRequest? {
        guard  let modelURL = Bundle.main.url(forResource: modelName, withExtension: modelExt) else {
            return nil
        }
        guard let vnCoreMLModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) else {
            return nil
        }
        return VNCoreMLRequest(model: vnCoreMLModel, completionHandler: completionHandler)
    }
    
    func handleImageClassifier(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        if let topResult = results.first{
            DispatchQueue.main.async {
                self.messageLabel.text = "\(topResult.identifier)입니다. 아무곳이나 클릭하세요"
            }
        }
    }
}
