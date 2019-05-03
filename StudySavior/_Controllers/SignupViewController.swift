//
//  SignupViewController.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/3/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    @IBOutlet weak var generalTitle: UILabel!
    
    @IBOutlet weak var generalButton: UIButton!
    
    @IBOutlet weak var name: UITextField!
    var nameString: String = ""
    @IBOutlet weak var major: UITextField!
    var majorString: String = ""
    @IBOutlet weak var number: UITextField!
    var numberString: String = ""
    var homeBaseString: String = " "
    
    @IBOutlet weak var c1: UITextField!
    var course1: String = ""
    @IBOutlet weak var c2: UITextField!
    var course2: String = ""
    @IBOutlet weak var c3: UITextField!
    var course3: String = ""
    @IBOutlet weak var c4: UITextField!
    var course4: String = ""
    @IBOutlet weak var c5: UITextField!
    var course5: String = ""
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
        
        switch (self.generalTitle.tag) {
        case 0:
            self.name.becomeFirstResponder()
        case 1:
            self.c1.becomeFirstResponder()
        default:
            self.email.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        if let email = email.text, !email.isEmpty {
            if let password = password.text, !password.isEmpty {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    let uid = (Auth.auth().currentUser?.uid)!
                    Firestore.firestore().collection("users").document(uid).setData([
                        "name": self.nameString,
                        "major": self.majorString,
                        "number": self.numberString,
                        "hoembase": self.homeBaseString,
                        "courses": [self.course1, self.course2, self.course3, self.course4, self.course5].filter({ (course) -> Bool in
                            return course != ""
                        })
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
            }
        }

    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if self.generalTitle.tag == 0 {
            if let name = name.text, !name.isEmpty, let major = major.text, !major.isEmpty, let pn = number.text, !pn.isEmpty, homeBaseString != ""  {
                return true
            }
        }
        else if self.generalTitle.tag == 1 {
            if let c1 = c1.text, !c1.isEmpty, let c2 = c2.text, !c2.isEmpty, let c3 = c3.text, !c3.isEmpty  {
                return true
            }
        }
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.generalTitle.tag == 0 {
            let controller = segue.destination as! SignupViewController
            if let name = name.text {
                controller.nameString = name
            }
            if let major = major.text {
                controller.majorString = major
            }
            if let number = number.text {
                controller.numberString = number
            }
            controller.homeBaseString = homeBaseString
        }
        else if self.generalTitle.tag == 1 {
            let controller = segue.destination as! SignupViewController
            if let c1 = c1.text {
                controller.course1 = c1
            }
            if let c2 = c2.text {
                controller.course2 = c2
            }
            if let c3 = c3.text {
                controller.course3 = c3
            }
            if let c4 = c4.text {
                controller.course4 = c4
            }
            if let c5 = c5.text {
                controller.course5 = c5
            }
            controller.nameString = self.nameString
            controller.majorString = self.majorString
            controller.numberString = self.numberString
            controller.homeBaseString = homeBaseString
        }
    }

    @IBAction func buttonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let c = [c1.text!, c2.text!, c3.text!, c4.text!, c5.text!]
//
//        let student = Student(name: name.text!, major: major.text!, classes: c, location: location.text!, number: number.text!, email: email.text!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        self.generalButton.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 0, blur: 5, spread: 0)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.25) {
                self.bottomConstraint.constant = keyboardHeight + 30
            }
        }
    }
}

