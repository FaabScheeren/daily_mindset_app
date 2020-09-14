//
//  GoalData.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 20/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct CheckQuestionData: Encodable {
    var title: String
    var done: Bool?
}

struct GoalResponse: Decodable {
    var goals: [CheckQuestionDataResponse]
}

struct TaskResponse: Decodable {
    var tasks: [CheckQuestionDataResponse]
}

struct PersonResponse: Decodable {
    var peopleToConnect: [CheckQuestionDataResponse]
}

struct CheckQuestionDataResponse: Decodable {
    var title: String?
    var done: Bool
}
