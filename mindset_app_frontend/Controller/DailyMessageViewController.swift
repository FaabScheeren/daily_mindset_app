//
//  DailyMessageViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 10/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyMessageViewController: UIViewController, QuestionManagerDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var questionManager = QuestionManager()
    var messageManager = MessageManager()
    var isUnwind: Bool = false
    var day: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionManager.delegate = self
        questionManager.getQuestions() {(succes) in
            if (succes) {
                print("Finished")
            } else {
                print("Error")
            }
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    
    @IBAction func toNextScreen(_ sender: UIButton) {
        if !textView.text.isEmpty {
            if (self.isUnwind) {
                messageManager.updateMessage(with: textView.text, finished: {(succes) -> Void in
                    if(succes) {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "FromDailyMessageToOverview", sender: sender)
                        }
                    } else {
                        //                errorLabel.text = "Something went wrong sorry."
                        print("Error")
                    }
                })
            } else {
                messageManager.saveMessage(data: textView.text, day: day, completion: {(statusCode: Int) -> Void in
//                    if(finished) {
                        if (200...299).contains(statusCode) {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "ToDailyMindsetScreen", sender: sender)
                            }
                        } else if (400...499).contains(statusCode) {
                            DispatchQueue.main.async {
                                self.errorLabel.text = "Please make sure you filled in the all the required fields."
                            }
                        } else if (500...599).contains(statusCode) {
                            DispatchQueue.main.async {
                                self.errorLabel.text = "Sorry, couldn't reach our server."
                            }
                        } else if (700...).contains(statusCode) {
                            DispatchQueue.main.async {
                                self.errorLabel.text = "Sorry, something went wrong. Try again later."
                            }
                        }
//                    }
                })
            }
            
        } else {
            errorLabel.text = "Please fill in your daily message."
        }
    }
    
    @IBAction func unwindToDailyMessage( _ seg: UIStoryboardSegue) {
        isUnwind = true
    }
    
    func didUpdateQuestion(questions: [Question]) {
        DispatchQueue.main.async {
            self.titleLabel.text = questions[0].question
        }
    }
}

//    fileprivate func resize(textView: UITextView) {
//        var newFrame = textView.frame
//        let width = newFrame.size.width
//        let newSize = textView.sizeThatFits(CGSize(width: width,
//                                                   height: CGFloat.greatestFiniteMagnitude))
//        newFrame.size = CGSize(width: width, height: newSize.height)
//        textView.frame = newFrame
//    }

