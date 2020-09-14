//
//  DailyJournalOverviewViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 31/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyJournalOverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackToJournal(_ sender: UIButton) {
        performSegue(withIdentifier: "backToJournal", sender: sender)
    }
    
    @IBAction func BackToScorecard(_ sender: UIButton) {
        performSegue(withIdentifier: "backToScorecard", sender: sender)
    }
    @IBAction func BackToHome(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
