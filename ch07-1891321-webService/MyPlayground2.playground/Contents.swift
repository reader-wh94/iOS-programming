import UIKit

let session = URLSession(configuration: .default)
let url = URL(string: "http://www.hansung.ac.kr")
let request = URLRequest(url: url!)
let dataTask = session.dataTask(with: request){
    (data, response, error) in
    if let error = error{
        print(error)
        return
    }
    if let jsonData = data{
        if let jsonString = String(data: jsonData, encoding: .utf8){
            print(jsonString)
        }
    }
}
dataTask.resume()
