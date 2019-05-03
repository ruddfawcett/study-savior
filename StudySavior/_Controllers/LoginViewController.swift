//
//  LoginViewController.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/3/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.loginButton.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 0, blur: 5, spread: 0)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = email.text, !email.isEmpty {
            if let password = password.text, !password.isEmpty {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    self.performSegue(withIdentifier: "homeScreen", sender: self)
                }
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.25) {
                self.bottomConstraint.constant = keyboardHeight
            }
        }
    }
}
