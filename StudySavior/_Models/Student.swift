//
//  Student.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import Foundation

class Student {
    
    var name: String
    var major: String
    var classes: [String]
    var location: String
    var number: String
    var email: String
    
    static let ally = Student(name: "Ally Klionsky", major: "Arts, Technology, and the Business of Innovation", classes: ["PSYC-100","BIO-510","BISC-110"], location: "West 27th", number: "415-786-8128", email: "")
    static let rudd = Student(name: "Ally Klionsky", major: "Art, East Asian Languages & Literatures", classes: ["CHNS-140","ACAD-220"], location: "New North", number: "", email: "")
    static let elly = Student(name: "Elly Berge", major: "Computer Science, Computer Security", classes: ["PSYC-110","BIO-510","BISC-110","ACAD-220","ACAD-180"], location: "New Mansion", number: "415-786-8128", email: "")
    static let liam = Student(name: "Michel Faliski", major: "Flilm Studies", classes: ["PSYC-110","BIO-510","BISC-110","ACAD-220","ACAD-180"], location: "The Village", number: "415-786-8128", email: "")
    
    var hash: String {
        get {
            return name + " " + classes.joined(separator: " ")
        }
    }
    
    init(name: String, major: String, classes: [String], location: String, number: String, email: String) {
        self.name = name
        self.major = major
        self.classes = classes
        self.location = location
        self.number = number
        self.email = email
    }
}
