//
//  SwiftModel.swift
//  UploadImg
//
//  Created by Appcare on 18/09/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import Foundation
import SwiftyJSON
class LikesModel: SMBaseModel {
    var data: [LikesListModel] = []
    
    override init() {
           super.init()
       }
       
       init?(_ jsonObject: JSON) {
           super.init(with: jsonObject)
          
           print(jsonObject)
           self.parseJSON(with: jsonObject)
       }
       
    private func parseJSON(with jsonObject: JSON) {
        for likes in jsonObject.arrayValue {
            print(likes)
            if let likeFor = LikesListModel.init(likes) {
                // print(likeFor)
                data.append(likeFor)
            }
        }
    }
}
class LikesListModel: SMBaseModel {
    
    var uid: String?
    var name: String?
    var like: String?
    var ppic: String?
    var cd: String?
    var commenttime: String?
   
    override init() {
        super.init()
    }
    
    init?(_ jsonObject: JSON) {
        super.init(with: jsonObject)
       
        print(jsonObject)
        self.parseJSON(with: jsonObject)
    }
    
    private func parseJSON(with jsonObject: JSON) {
        self.uid = jsonObject["uid"].stringValue
        self.name = jsonObject["name"].stringValue
        self.like = jsonObject["like"].stringValue
        self.ppic = jsonObject["ppic"].stringValue
        self.cd = jsonObject["cd"].stringValue
        self.commenttime = jsonObject["commenttime"].stringValue
    }
}
