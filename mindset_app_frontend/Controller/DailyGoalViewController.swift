//
//  DailyGoalViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 20/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

var Goals = [CheckQuestionData]()
let goalManager = GoalManager()

class DailyGoalViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var FirstGoal: UITextView!
    @IBOutlet weak var SecondGoal: UITextView!
    @IBOutlet weak var ThirdGoal: UITextView!

    var isUnwind: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstGoal.delegate = self
        SecondGoal.delegate = self
        ThirdGoal.delegate = self

        Goals.append(CheckQuestionData(title: "", done: false))
        Goals.append(CheckQuestionData(title: "", done: false))
        Goals.append(CheckQuestionData(title: "", done: false))
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func ToTaskScreen(_ sender: Any) {
        print("Goals: \(Goals)")
        goalManager.saveGoal(with: Goals) { (succes) in
            if (succes) {
                if (self.isUnwind) {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "FromDailyGoalsToOverview", sender: sender)
                    }
                } else {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ToTaskScreen", sender: sender)
                    }
                }
            } else {
//                errorLabel.text = "Something went wrong sorry."
                print("Error")
            }
        }
    }
    
    @IBAction func unwindToGoal( _ seg: UIStoryboardSegue) {
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        print(textView)
        if textView == FirstGoal {
            Goals[0] = (CheckQuestionData(title: FirstGoal.text, done: false))
//            print(Goals)
        } else if textView == SecondGoal {
            Goals[1] = (CheckQuestionData(title: SecondGoal.text, done: false))
//            print(Goals)
        } else if textView == ThirdGoal {
            Goals[2] = (CheckQuestionData(title: ThirdGoal.text, done: false))
//            print(Goals)
        }
    }
    
}
