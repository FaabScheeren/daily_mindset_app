//
//  questionData.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 13/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct Questions: Decodable {
    let questions: [Question]
}

struct Question: Decodable {
    let _id: String
    let category: String
    let sort: String
    let question: String
}
