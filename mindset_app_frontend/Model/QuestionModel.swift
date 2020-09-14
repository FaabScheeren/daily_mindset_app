//
//  QuestionModel.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 13/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct QuestionsModel {
//    var questions: [QuestionModel]
    var questions = [Question]()
    
    init(questions: [Question]? = nil) {
        if let question = questions {
            self.questions = question
        }
    }
}

struct QuestionModel {
    let _id: String
    let category: String
    let sort: String
    let question: String
}
