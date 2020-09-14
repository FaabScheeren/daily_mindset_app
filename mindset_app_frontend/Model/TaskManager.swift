//
//  TaskManager.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 21/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct TaskManager {
    func encodeJSON(with answers: [CheckQuestionData]) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(answers)
            return jsonData
        } catch {
            print("Error took place: \(error)")
            return nil
        }
    }
        
    func saveTask(with data: [CheckQuestionData], finished: @escaping (Bool) -> ()) {
        let url = URL(string: "\(Constants.baseURL)/daily_mindset/tasks/\(Constants.currentMindsetId)")!
//        let url = URL(string: "http://localhost:4000/daily_mindset/tasks/5f154da22afcd10a51718ac0")!
        //create the session object
        let session = URLSession.shared
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print("Data: \(data)")
        
        let jsonData = encodeJSON(with: data)
        request.httpBody = jsonData

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let savedTasks = try JSONDecoder().decode(TaskResponse.self, from: data)
                print("Response data:\n \(savedTasks)")
            } catch let jsonErr {
                print("\(jsonErr)")
            }
            finished(true)
        }
        task.resume()
    }
}
