//
//  DailyTaskViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 21/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

var Tasks = [CheckQuestionData]()
var taskManager = TaskManager()

class DailyTasksViewController: UIViewController {
    @IBOutlet weak var FirstTask: UITextView!
    @IBOutlet weak var SecondTask: UITextView!
    @IBOutlet weak var ThirdTask: UITextView!
    
    var isUnwind: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FirstTask.delegate = self
        SecondTask.delegate = self
        ThirdTask.delegate = self

        Tasks.append(CheckQuestionData(title: "", done: false))
        Tasks.append(CheckQuestionData(title: "", done: false))
        Tasks.append(CheckQuestionData(title: "", done: false))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func ToPersonScreen(_ sender: UIButton) {
        print("Tasks: \(Tasks)")
        taskManager.saveTask(with: Tasks) { (succes) in
            if (succes) {
                if (self.isUnwind) {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "FromDailyTasksToOverview", sender: sender)
                    }
                } else {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ToPersonScreen", sender: sender)
                    }
                }
            } else {
//                errorLabel.text = "Something went wrong sorry."
                print("Error")
            }
        }
    }
    
    @IBAction func unwindToTask( _ seg: UIStoryboardSegue) {
    }
    
}

extension DailyTasksViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        print(textView)
        if textView == FirstTask {
            Tasks[0] = (CheckQuestionData(title: FirstTask.text, done: false))
//            print(Tasks)
        } else if textView == SecondTask {
            Tasks[1] = (CheckQuestionData(title: SecondTask.text, done: false))
//            print(Tasks)
        } else if textView == ThirdTask {
            Tasks[2] = (CheckQuestionData(title: ThirdTask.text, done: false))
//            print(Tasks)
        }
    }
}
