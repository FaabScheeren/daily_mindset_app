//
//  DailyOverViewViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 21/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyOverViewViewController: UIViewController {

    var isUnwind: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func BackToDailyMessage(_ sender: Any) {
        performSegue(withIdentifier: "BackToDailyMessage", sender: sender)
    }
    
    @IBAction func BackToDailyMindset(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToDailyMindset", sender: sender)
    }
    
    @IBAction func BackToDailyGoal(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToDailyGoal", sender: sender)
    }
    
    @IBAction func BackToTaskScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToTask", sender: sender)
    }
    
    @IBAction func BackToPeopleScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPerson", sender: sender)
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
//        performSegue(withIdentifier: "BackFromDailyOverviewToHome", sender: sender)
        self.navigationController?.popToRootViewController(animated: true)
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        print("Stop! Hou op!")
    }
    
    
//    @IBAction func FinishMindset(_ sender: UIButton) {
//        performSegue(withIdentifier: "FromDailyOverviewToHome", sender: sender)
//    }
    
}
