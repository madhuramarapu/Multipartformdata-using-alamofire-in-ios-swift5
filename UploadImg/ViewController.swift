//
//  ViewController.swift
//  UploadImg
//
//  Created by Appcare on 17/09/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
class RestService {
   public static func loginUser(url:String,imageData: Data?, method:HTTPMethod, parameters: [String : Any],isLoader: Bool, title: String, description:String, vc:UIViewController, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void) {
     
    
        
         AF.upload(multipartFormData: { multipartFormData in
             
             for (key, value) in parameters {
                 if let temp = value as? String {
                     multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                 }
                 if let temp = value as? Int {
                     multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                 }
                 if let temp = value as? NSArray {
                     temp.forEach({ element in
                         let keyObj = key + "[]"
                         if let string = element as? String {
                             multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                         } else
                             if let num = element as? Int {
                                 let value = "\(num)"
                                 multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                         }
                     })
                 }
             }
             
             if let data = imageData{
                 multipartFormData.append(data, withName: "file", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
             }
         },
                   to: url, method: .post )
             .responseJSON(completionHandler: { (responseData) in
                 
                // Indicator.shared().hideIndicator(vc: vc)
                 
                 switch responseData.result{
                     
                 case .success(_):
                     success(responseData.data!)
                 case .failure(let error):
                     failure(error)
                     
                 }
                 
             })
       }
    
}
