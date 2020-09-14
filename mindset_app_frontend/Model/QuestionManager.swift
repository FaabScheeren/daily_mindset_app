//
//  Questions.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 10/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

protocol QuestionManagerDelegate {
    func didUpdateQuestion(questions: [Question])
}

var savedData = QuestionsModel()

struct QuestionManager {
    var delegate: QuestionManagerDelegate?
    
    func parseJSON(data: Data) -> QuestionsModel? {
        do {
            let decodedData = try JSONDecoder().decode(Questions.self, from: data)
            savedData = QuestionsModel(questions: decodedData.questions)
            return savedData
        } catch {
            print("Error took place\(error).")
            return nil
        }
    }
    
    func getQuestions(finished: @escaping (Bool) -> ()) {
        let url = URL(string: "\(Constants.baseURL)/questions")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let todoItem = self.parseJSON(data: data)

            if todoItem != nil {
                self.filterQuestions(category: "message")
            }
//            print(todoItem)
            finished(true)
        }
        task.resume()
    }

    func filterQuestions(category: String) {
        let filteredData = savedData.questions.filter { question in
            return question.category == category
        }
        self.delegate?.didUpdateQuestion(questions: filteredData)
    }
}

