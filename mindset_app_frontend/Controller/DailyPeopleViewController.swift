//
//  DailyPeopleViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 21/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit
var Persons = [CheckQuestionData]()
var personManager = PersonManager()

class DailyPeopleViewController: UIViewController {
    @IBOutlet weak var FirstPerson: UITextView!
    @IBOutlet weak var SecondPerson: UITextView!
    @IBOutlet weak var ThirdPerson: UITextView!
    
//    var isUnwind: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FirstPerson.delegate = self
        SecondPerson.delegate = self
        ThirdPerson.delegate = self

        Persons.append(CheckQuestionData(title: "", done: false))
        Persons.append(CheckQuestionData(title: "", done: false))
        Persons.append(CheckQuestionData(title: "", done: false))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func GoToDailyOverviewScreen(_ sender: Any) {
        print("Tasks: \(Tasks)")
            personManager.savePersons(with: Persons) { (succes) in
                if (succes) {
//                    if (self.isUnwind) {
//                        DispatchQueue.main.async {
//                        self.performSegue(withIdentifier: "FromDailyPeopleToOverview", sender: sender)
//                        }
//                    } else {
                        DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ToMindsetOverviewScreen", sender: sender)
                        }
//                    }
                } else {
    //                errorLabel.text = "Something went wrong sorry."
                    print("Error")
                }
            }
    }
    
    @IBAction func unwindToPeople( _ seg: UIStoryboardSegue) {
    }
    
}

extension DailyPeopleViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView)
        if textView == FirstPerson {
            Persons[0] = (CheckQuestionData(title: FirstPerson.text, done: false))
            print(Persons)
        } else if textView == SecondPerson {
            Persons[1] = (CheckQuestionData(title: SecondPerson.text, done: false))
            print(Persons)
        } else if textView == ThirdPerson {
            Persons[2] = (CheckQuestionData(title: ThirdPerson.text, done: false))
            print(Persons)
        }
    }
}
