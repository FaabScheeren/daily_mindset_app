//
//  DailyMindsetOverviewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 09/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyMindsetOverviewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var journalsList = ["Today", "Yesterday"]
    var mindsetList = ["Today", "Tommorow"]
    var selectedOption: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func unwindFromEveningJournal( _ seg: UIStoryboardSegue) {
    }

    @IBAction func DailyMessage(_ sender: UIButton) {
//        performSegue(withIdentifier: "ToMessageScreen", sender: sender)
        showPickerInActionSheet(sentBy: "mindset")
    }
    
    @IBAction func StartDailyJournal(_ sender: UIButton) {
        showPickerInActionSheet(sentBy: "journal")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMessageScreen" {
            if let destinationVC = segue.destination as? DailyMessageViewController {
                destinationVC.day = selectedOption
            }
        } else if segue.identifier == "ToJournalScreen" {
            if let destinationVC = segue.destination as? DailyJournalViewController {
                destinationVC.day = selectedOption
            }
        }
    }
    
//    func showPickerInActionSheet() {
    func showPickerInActionSheet(sentBy: String) {
        let title = "Choose your day"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet);
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        
        let newWidth = UIScreen.main.bounds.width * 0.88
        let marginLeft = newWidth - 117
        
        //Create a frame (placeholder/wrapper) for the picker and then create the picker
        let pickerFrame: CGRect = CGRect(x: 17, y: 102, width: newWidth, height: 100); // CGRect(left), top, width, height) - left and top are like margins
        let picker: UIPickerView = UIPickerView(frame: pickerFrame);

        if(sentBy == "mindset"){
            selectedOption = mindsetList[0]
            picker.tag = 1;
        } else if (sentBy == "journal"){
            selectedOption = journalsList[0]
            picker.tag = 2;
        } else {
            picker.tag = 0;
        }
 
        //set the pickers datasource and delegate
        picker.delegate = self;
        picker.dataSource = self;

        //Add the picker to the alert controller
        alert.view.addSubview(picker);

        //Create the toolbar view - the view witch will hold our 2 buttons
        let toolFrame = CGRect(x: 17, y: 55, width: newWidth, height: 45);
        let toolView: UIView = UIView(frame: toolFrame);

        //add buttons to the view
        let buttonCancelFrame: CGRect = CGRect(x: 0, y: 7, width: 100, height: 30); //size & position of the button as placed on the toolView

        //Create the cancel button & set its title
        let buttonCancel: UIButton = UIButton(frame: buttonCancelFrame);
        buttonCancel.setTitle("Cancel", for: UIControl.State.normal);
        buttonCancel.setTitleColor(UIColor.blue, for: UIControl.State.normal);
        toolView.addSubview(buttonCancel); //add it to the toolView

        //Add the target - target, function to call, the event witch will trigger the function call
        buttonCancel.addTarget(self, action: #selector(self.cancelSelection), for: UIControl.Event.touchDown);


        //add buttons to the view
        let buttonOkFrame: CGRect = CGRect(x: marginLeft, y: 7, width: 100, height: 30); //size & position of the button as placed on the toolView

        //Create the Select button & set the title
        let buttonOk: UIButton = UIButton(frame: buttonOkFrame);
        buttonOk.setTitle("Select", for: UIControl.State.normal);
        buttonOk.setTitleColor(UIColor.blue, for: UIControl.State.normal);
        toolView.addSubview(buttonOk); //add to the subview

        //Add the tartget. In my case I dynamicly set the target of the select button
        if(sentBy == "mindset"){
            buttonOk.addTarget(self, action: #selector(self.goToMindset), for: UIControl.Event.touchDown);
        } else if (sentBy == "journal"){
            buttonOk.addTarget(self, action: #selector(self.goToJournal), for: UIControl.Event.touchDown);
        }

//        add the toolbar to the alert controller
        alert.view.addSubview(toolView);

        self.present(alert, animated: true, completion: nil);
    }

    @objc func goToMindset(sender: UIButton){
        // Your code when select button is tapped
        self.dismiss(animated: true, completion: nil);
        if selectedOption.isEmpty {
            selectedOption = mindsetList[0]
        }
        
        performSegue(withIdentifier: "ToMessageScreen", sender: sender)
    }

    @objc func goToJournal(sender: UIButton){
        // Your code when select button is tapped
        self.dismiss(animated: true, completion: nil);
        
        if selectedOption.isEmpty {
            selectedOption = journalsList[0]
        }
        
        performSegue(withIdentifier: "ToJournalScreen", sender: sender)
    }
    


    @objc func cancelSelection(sender: UIButton){
        self.dismiss(animated: true, completion: nil);
    }

    // returns number of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return 2
    }

    // Return the title of each row in your picker ... In my case that will be the profile name or the username string
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            let selectedOption = self.mindsetList[row]
            return selectedOption;

        } else if(pickerView.tag == 2){
            let selectedJournal = self.journalsList[row]
            return selectedJournal;

        } else  {

            return "";
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            let choosenOption = mindsetList[row]
            self.selectedOption = choosenOption
        } else if (pickerView.tag == 2){
            let choosenOption = journalsList[row]
            self.selectedOption = choosenOption
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
