//
//  MindsetAnswersManager.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

protocol MindsetManagerDelegate {
    func didFindMindset(find: Bool)
}

struct MindsetAnswersManager {
    var delegate: MindsetManagerDelegate?
    
    func encodeJSON(with answers: [MindsetAnswersData]) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(answers)
            return jsonData
        } catch {
            print("Error took place: \(error)")
            return nil
        }
    }
    
    func saveAnswers(with data: [MindsetAnswersData], onQuestions: String, url parameter: String, finished: @escaping (Bool) -> ()) {
        let url = URL(string: "\(Constants.baseURL)/daily_mindset/\(parameter)/\(Constants.currentMindsetId)")
        //        let url = URL(string: "http://localhost:4000/daily_mindset/\(parameter)/5f1fdf03c103cd2f9f0f557c")
        guard let requestUrl = url else {fatalError()}
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = encodeJSON(with: data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error at session: \(error)")
                return
            }
            
            guard let data = data else {return}
            do {
                if (onQuestions == "mindset") {
                    let savedAnswers = try JSONDecoder().decode(MindsetAnswersDataDecode.self, from: data)
                    print("Response data:\n \(savedAnswers)")
                } else if (onQuestions == "journal") {
                    let savedAnswers = try JSONDecoder().decode(JournalsAnswersDataDecode.self, from: data)
                    print("Response data:\n \(savedAnswers)")
                }
            } catch let jsonErr {
                print("\(jsonErr)")
            }
            finished(true)
        }
        task.resume()
    }
    
    func encodeHabits(with answers: [HabitsScorecardAnswers]) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(answers)
            return jsonData
        } catch {
            print("Error took place: \(error)")
            return nil
        }
    }
    
    func saveHabits(with data: [HabitsScorecardAnswers], url parameter: String, finished: @escaping (Bool) -> ()) {
        print(Constants.currentMindsetId)
        let url = URL(string: "\(Constants.baseURL)/daily_mindset/\(parameter)/\(Constants.currentMindsetId)")
        //        let url = URL(string: "http://localhost:4000/daily_mindset/\(parameter)/5f1fdf03c103cd2f9f0f557c")
        guard let requestUrl = url else {fatalError()}
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = encodeHabits(with: data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error at session: \(error)")
                return
            }
            
            guard let data = data else {return}
            do {
                let savedAnswers = try JSONDecoder().decode(HabitsScorecardAnswers.self, from: data)
                print("Response data:\n \(savedAnswers)")
            } catch let jsonErr {
                print("\(jsonErr)")
            }
            finished(true)
        }
        task.resume()
    }
    
//    Fetch one specific mindset of the current logged in user and date.
    func getMindset(date: String) {
        print("The date is: \(date)")
        let url = URL(string: "\(Constants.baseURL)/daily_mindset/\(Constants.userId)/\(date)")
        guard let requestUrl = url else {fatalError()}
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error at session: \(error)")
                return
            }
            
            guard let data = data else {return}
            do {
                let savedAnswers = try JSONDecoder().decode(MindsetData.self, from: data)
                //                print("Response data:\n \(savedAnswers)")
                if let id = savedAnswers.id {
//                    print(id)
                    Constants.currentMindsetId = id
                    DispatchQueue.main.async {
                        self.delegate?.didFindMindset(find: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.didFindMindset(find: false)
                    }
                }
            } catch let jsonErr {
                self.delegate?.didFindMindset(find: false)
                print("\(jsonErr)")
            }
            //            finished(true)
        }
        task.resume()
    }
}
