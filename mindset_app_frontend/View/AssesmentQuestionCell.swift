//
//  AssesmentQuestionCell.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 30/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class AssesmentQuestionCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var assesmentPicker: UIPickerView!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    var pickerData = ["1", "2", "3", "4", "5", "6"]
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.assesmentPicker.delegate = self
        self.assesmentPicker.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
        return 6
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 100.0
//    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // reset (hide) the checkmark label
        self.QuestionLabel.text = ""

    }
}
