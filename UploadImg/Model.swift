//
//  Model.swift
//  UploadImg
//
//  Created by Appcare on 18/09/20.
//  Copyright © 2020 Appcare. All rights reserved.
//


import Foundation
import SwiftyJSON

struct SMModelError {
    var errorCode: String?
    var errorMessage: String?
}

struct SMModelMessage {
    var displayMessage: String?
    var serviceMessageList: [Any]?
    var messageLevel: String?
}

class SMBaseModel {

    var isSuccess: Bool?
    var status: String?
    var duration: Double?
    var error: SMModelError?
    var message: SMModelMessage?

    init(with response: JSON) {

        self.isSuccess = response["success"].boolValue
        self.status = response["status"].stringValue
        self.duration = response["duration"].doubleValue

        let errorResponse = response["error"]
        if !errorResponse.isEmpty {
            self.error = SMModelError()
            self.error?.errorCode = errorResponse["errorCode"].stringValue
            self.error?.errorMessage = errorResponse["errorMessage"].stringValue
        }

        let messageResponse = response["message"]
        if !messageResponse.isEmpty {
            self.message = SMModelMessage()
            self.message?.displayMessage = messageResponse["displayMessage"].stringValue
            self.message?.messageLevel = messageResponse["messageLevel"].stringValue
            self.message?.serviceMessageList = messageResponse["serviceMessageList"].arrayValue
        }
    }

    init() {
    }
}
