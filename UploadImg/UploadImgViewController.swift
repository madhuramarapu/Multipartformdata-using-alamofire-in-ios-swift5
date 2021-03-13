//
//  UploadImgViewController.swift
//  UploadImg
//
//  Created by Appcare on 17/09/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UploadImgViewController: UIViewController {
    
    var feedLikes: LikesModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        var parameters : [String:String] = [:]
        parameters["uid"] = "B00919036363636"
        parameters["API-KEY"] = "827ccb0eea8a706c4c34a16891f84e7b"
        let image = UIImage.init(named: "Simulator Screen")
        let imgData = image!.jpegData(compressionQuality: 0.5)!
        
        uploadImage(isUser: true, endUrl: "http://13.234.112.159/hcc/index.php/api/Services/profilePhotoUpload", imageData: imgData, parameters: parameters)
        
        // imag2()
    }
    
    
    func imageData(){
        
    }
    
    
    func uploadImage(isUser:Bool, endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((_ isSuccess:Bool) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        
        
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
                multipartFormData.append(data, withName: "profile_pic[]", fileName: "\(Date.init().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                
                // multipartFormData.append(data, withName: "profilepic[]", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
            }
        },
                  to: endUrl, method: .post )
            .responseJSON(completionHandler: { (response) in
                
                
                if let err = response.error{
                    print(err)
                    onError?(err)
                    return
                }
                print("Succesfully uploaded")
                
                let json = response.data
                
                if (json != nil)
                {
                    let jsonObject = JSON(json!)
                    print(jsonObject)
                    DispatchQueue.main.async {
                        self.feedLikes = LikesModel.init(jsonObject)
                        print(self.feedLikes,"self.feedLikes")
                        
                        let madhu =   jsonObject["message"].stringValue
                        print(madhu)
                        let uid =   jsonObject["data"]["uid"].stringValue
                        print(uid)
                        
                        print(self.feedLikes?.data.count)
                        
                    }
                    
                    
                }
            })
    }
    func json(Json:JSON){
        let message = Json["name"].stringValue
        print("message",message)
    }
    func parseResponse(with response: JSON) {
        print(response)
        
        let id = response["message"].stringValue
        print("message",id)
    }
    
    func imag2(){
        var parameters : [String:String] = [:]
        parameters["uid"] = "B00919036363636"
        parameters["API-KEY"] = "827ccb0eea8a706c4c34a16891f84e7b"
        let image = UIImage.init(named: "Simulator Screen")
        let imgData = image!.jpegData(compressionQuality: 0.5)!
        
        RestService.loginUser(url: "http://13.233.148.166/index.php/api/Services/profilePhotoUpload", imageData: imgData, method: .post, parameters: parameters,isLoader: true, title: "", description: "", vc: self, success: { (response) in
            do{
                print(response)
            }catch{
                print(error.localizedDescription)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
