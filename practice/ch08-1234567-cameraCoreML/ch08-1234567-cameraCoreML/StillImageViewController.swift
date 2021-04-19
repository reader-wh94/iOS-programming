//
//  ViewController.swift
//  ch08-1234567-cameraCoreML
//
//  Created by Jae Moon Lee on 2021/04/13.
//

import UIKit
import Vision
import CoreML

class StillImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var request :VNCoreMLRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(takePicture))
        imageView.addGestureRecognizer(tap)
        // imageView.isUserInteractionEnabled = true
        
        messageLabel.layer.borderWidth = 2
        messageLabel.layer.borderColor = UIColor.red.cgColor
        messageLabel.text = "Please wait for loading the model"
        
       // createCoreMLRequestFromRemote(urlStr: "https://ml-assets.apple.com/coreml/models/Image/ImageClassification/Resnet50/Resnet50.mlmodel", completionHandler: handleImageClassifier)
        
        // createCoreMLRequestFromRemote(urlStr: "http://34.64.120.108/models/Resnet50.mlmodel", completionHandler: handleImageClassifier)
        
        request = createCoreMLRequest(modelName: "SqueezeNet", modelExt: "mlmodelc", completionHandler: handleImageClassifier)
    }
}

extension StillImageViewController{
    @objc func takePicture(sender: UITapGestureRecognizer){
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
        }else{
            imagePickerController.sourceType = .photoLibrary
        }
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension StillImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            
            let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
            try! handler.perform([request!])
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension StillImageViewController{
    func createCoreMLRequest(modelName: String, modelExt: String, completionHandler: @escaping (VNRequest, Error?) -> Void) -> VNCoreMLRequest? {
       
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: modelExt) else{
            return nil
        }
        
        print(modelURL)
        done()

        guard let vnCoreMLModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) else{
            return nil
        }
        return VNCoreMLRequest(model: vnCoreMLModel, completionHandler: completionHandler)
    }
    
    func handleImageClassifier(request: VNRequest, error: Error?){
        guard let results = request.results as? [VNClassificationObservation] else{
            return
        }
        if let topResult = results.first{
            DispatchQueue.main.async{
                self.messageLabel.text = "\(topResult.identifier)입니다. 아무곳이나 클릭하세요"
            }
        }
    }
}

extension StillImageViewController{
    func createCoreMLRequestFromRemote (urlStr: String, completionHandler: @escaping (VNRequest, Error?) -> Void){

        // 저장하고자 하는 곳의 디렉토리를 준비한다.
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        // 원하는 디렉토리의 파일명을 지정한다.
        let docuemntPath = documentDirectory.appendingPathComponent("downloaded.mlmodel")
        print(docuemntPath)     // 여기가 어딜까?
        // 파일이 있으면 그냥 리턴하자.
        if FileManager.default.fileExists(atPath: docuemntPath.path){
            done()
            return
        }

        // 파일을 다운로드 한다
        let fileURL = URL(string: urlStr)
        let task = URLSession.shared.downloadTask(with: fileURL!) {
            // 다운로드가 다 된경우 호출되는 callback 함수이다.
            (localURL, urlResponse, error) in
            guard let localURL = localURL else{
                print("Error in downloading\(error!)")
                return
            }
            do {
                try FileManager.default.copyItem(at: localURL, to: docuemntPath)
                // 다운로드 받은 파일을 분해하여 mlmodelc로 만든다.
                let modelURL = try? MLModel.compileModel(at: docuemntPath)
                
                // 아래 내용은 폰내의 모델을 액세스하는 것과 동일하다.
                guard let vnCoreMLModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL!)) else{
                    return
                }
                self.request = VNCoreMLRequest(model: vnCoreMLModel, completionHandler: completionHandler)
                if let _ = self.request{
                    DispatchQueue.main.async {
                        self.done()
                    }
                }
            }
            catch {
                print("Error in copying to playground's documents directory \(error)")
            }
        }

        task.resume()
    }
    func done(){
        imageView.isUserInteractionEnabled = true
        messageLabel.text = "아무곳이나 클릭하세요"
    }
}
