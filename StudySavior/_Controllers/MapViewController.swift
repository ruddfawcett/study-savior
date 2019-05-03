//
//  MapViewController.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var reusableTableView: ReusableTableView!
    
    var students = [Student.ally, Student.elly, Student.liam, Student.rudd]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: 34.024894,longitude: -118.2829904)
        
        let regionRadius: CLLocationDistance = 2500
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
      
        tableView.tableHeaderView = (UINib(nibName: "TableHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView)
        reusableTableView = ReusableTableView(tableView, self.students)
        reusableTableView.didSelectCellClosure =  {(s: Any) -> Void in
            self.performSegue(withIdentifier: "showDetail", sender: s)
        }
        
        reusableTableView.tableView.reloadData()
        
        let locs = [Pin.west, Pin.row, Pin.nn, Pin.newmans, Pin.village, Pin.zo, Pin.cc, Pin.doheny, Pin.parkside]
        for s in students {
            for i in locs {
                if i.title == s.location {
                    mapView.addAnnotation(i)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = sender as? IndexPath {
                let student: Student
                student = students[indexPath.row]
                
                reusableTableView.tableView.deselectRow(at: indexPath, animated: true)
                
                let controller = segue.destination as! StudentViewController
                controller.isMyProfile = false
                controller.student = student
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.image = UIImage(named: "location")
        return annotationView
    }
}

