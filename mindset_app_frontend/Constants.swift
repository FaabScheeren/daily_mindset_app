//
//  Constants.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct Constants {
    static var currentMindsetId = ""
    static var userId = "5f05c3fa88fc936e61e1ef0c"
//    static var baseURL = "https://mindset-app.herokuapp.com"
    static var baseURL = "http://localhost:4000"
}

struct GlobalFunctions {
    static func getDate(with days: Int) -> String {
        // Convert date to string in right format
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = days
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)

        let myString = formatter.string(from: futureDate!) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
        
}
