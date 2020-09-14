//
//  DailyHabbitScorecardViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 30/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

var habitsScorecardAnswer = [HabitsScorecardAnswers]()

class DailyHabitScorecardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var habitsScorecardManager = MindsetAnswersManager()
    var assesmentQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AssesmentQuestionCell", bundle: nil), forCellReuseIdentifier: "AssesmentQuestionCellId")
        
        self.assesmentQuestions = savedData.questions.filter { question in
            return question.category == "habits_scorecard"
        }
        
        for question in self.assesmentQuestions {
            // Appending a struct to the answer array
            let answer = HabitsScorecardAnswers(question: question._id, assesment: 1)
            habitsScorecardAnswer.append(answer)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assesmentQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AssesmentQuestionCellId", for: indexPath) as! AssesmentQuestionCell
//        cell.delegate = self
        
        let country = assesmentQuestions[indexPath.row]
        cell.QuestionLabel?.text = country.question
//        cell.id = country._id
//        cell.indexOfCell = indexPath.row
        
        // Makes the tableview fit the content
//        cell.textChanged {[weak tableView] (_) in
//            tableView?.beginUpdates()
//            tableView?.endUpdates()
//        }
        
//        if(journalAnswers[indexPath.row].answer != "") {
//            cell.questionInputField.text = journalAnswers[indexPath.row].answer
//        }
        
        return cell
    }
    
//    func textViewChanged(textView: UITextView, indexOfCell: Int) {
//        journalAnswers[indexOfCell].answer = textView.text
//    }
    
    @IBAction func GoToDailyJournalOverview(_ sender: Any) {
        habitsScorecardManager.saveHabits(with: habitsScorecardAnswer, url: "habits_scorecard") { (succes) in
            if (succes) {
                print("Succes")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toDailyJournalOverviewScreen", sender: sender)
                }
            } else {
                print("Error in saving journal answers.")
            }
        }
    }
    
    @IBAction func unwindToScorecard( _ seg: UIStoryboardSegue) {
    }
    
}
