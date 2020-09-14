//
//  MessageData.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct MessageData: Codable {
//    var category: String
//    var sort: String
//    var question: String
//    var answer: String
    var _id: String?
    var today_message: String
    var day: String?
}

struct UpdateMessageData: Codable {
    var _id: String?
    var today_message: String
}
