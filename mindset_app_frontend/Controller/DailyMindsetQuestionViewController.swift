    
//  DailyMindsetQuestionViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 14/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

//class QuestionTableViewCell: UITableViewCell {
//    @IBOutlet weak var questionTitleLabel: UILabel!
//}

var mindsetQuestions = [Question]()
var mindsetAnswers = [MindsetAnswersData]()
var mindsetAnswersManager = MindsetAnswersManager()

class DailyMindsetQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate  {
    @IBOutlet weak var tableView: UITableView!
    
    var isUnwind: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "OpenQuestionCell", bundle: nil), forCellReuseIdentifier: "MindsetQuestionsCell")
        
        mindsetQuestions = savedData.questions.filter { question in
            return question.category == "morning_mindset"
        }
        
        for question in mindsetQuestions {
            // Appending a struct to the answer array
            let answer = MindsetAnswersData(question: question._id, answer: "")
            mindsetAnswers.append(answer)
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height + 75), right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // MARK: - Navigation
    @IBAction func saveMindsetAnswers(_ sender: UIButton) {
        mindsetAnswersManager.saveAnswers(with: mindsetAnswers, onQuestions: "mindset", url: "mindset_questions") { (succes) in
            if (succes) {
                if (self.isUnwind) {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "FromMindsetToOverview", sender: sender)
                    }
                } else {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ToGoalScreen", sender: sender)
                    }
                }
            } else {
//                errorLabel.text = "Something went wrong sorry."
                print("Error")
            }
        }
    }
    
    @IBAction func unwindToDailyMindset( _ seg: UIStoryboardSegue) {
        isUnwind = true
    }
    
    // MARK: - Tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mindsetQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MindsetQuestionsCell", for: indexPath) as! OpenQuestionCell
        cell.delegate = self
        
        let country = mindsetQuestions[indexPath.row]
        cell.questionTitleLabel?.text = country.question
        cell.id = country._id
        cell.indexOfCell = indexPath.row
        
        // Makes the tableview fit the content
        cell.textChanged {[weak tableView] (_) in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }

        if(mindsetAnswers[indexPath.row].answer != "") {
            cell.questionInputField.text = mindsetAnswers[indexPath.row].answer
        }
        
        return cell
    }
    
    func textViewChanged(textView: UITextView, indexOfCell: Int) {
        mindsetAnswers[indexOfCell].answer = textView.text
    }
}
