//
//  StudentViewController.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

import Firebase

class StudentViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var topMapConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var generalButton: UIButton!
    
    var student: Student!
    var isMyProfile = true
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var course1: CourseTag?
    @IBOutlet weak var course2: CourseTag?
    @IBOutlet weak var course3: CourseTag?
    @IBOutlet weak var course4: CourseTag?
    @IBOutlet weak var course5: CourseTag?
    @IBOutlet weak var course6: CourseTag?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        let locs = [Pin.west, Pin.row, Pin.nn, Pin.newmans, Pin.village, Pin.zo, Pin.cc, Pin.doheny, Pin.parkside]
        
        if isMyProfile {
            self.generalButton.setTitle("Sign Out", for: .normal)
            self.backButton.removeFromSuperview()
            student = Student.ally
        }

        generalButton.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 0, blur: 5, spread: 0)
        
        drawLabels()
        drawTags()
        
        let regionRadius: CLLocationDistance = 750
        var initialLocation = CLLocation()
        
        for pin in locs {
            if pin.title == student.location {
                mapView.addAnnotation(pin)
                initialLocation = CLLocation(latitude: pin.coordinate.latitude,longitude: pin.coordinate.longitude)
            }
        }
        
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
    }

    @IBAction func generalButtonAction(_ sender: UIButton) {
        if isMyProfile {
            try! Auth.auth().signOut()
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
        else {
            displayMessageInterface()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [student.number]
        composeVC.body = "Hi \(student.name), I found you on StudyBuddy. Do you want to study?"
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        return
    }
    
    func drawLabels() {
        if let student = student {
            nameLabel.text = student.name
            majorLabel.text = student.major
        }
    }
    
    func drawTags() {
        var courseTags = [course1, course2, course3, course4, course5, course6]

        for (i, course) in student.classes.enumerated() {
            if let tag = courseTags[i] {
                tag.text = course
            }
        }
        
        if student.classes.count < 4 {
            self.view.removeConstraint(self.topMapConstraint)
            self.view.addConstraint(NSLayoutConstraint(item: self.mapView!, attribute: .top, relatedBy: .equal, toItem: course1, attribute: .bottom, multiplier: 1, constant: 30))
        }
        
        courseTags.removeFirst(student.classes.count)
        
        for tag in courseTags {
            if let tag = tag {
                tag.removeFromSuperview()
            }
        }
    }
}

extension StudentViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.image = UIImage(named: "location")
        return annotationView
    }
}
