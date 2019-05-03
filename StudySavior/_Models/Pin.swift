//
//  mapLocations.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/3/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    static let west = Pin(title: "West 27th", coordinate: CLLocationCoordinate2D(latitude: 34.0268548, longitude:-118.2762075))
    static let row = Pin(title: "Row House", coordinate: CLLocationCoordinate2D(latitude: 34.0263952, longitude: -118.2786741))
    static let nn = Pin(title: "New North", coordinate: CLLocationCoordinate2D(latitude: 34.0206513, longitude: -118.2837773))
    static let newmans = Pin(title: "New Mansion", coordinate: CLLocationCoordinate2D(latitude: 34.024776, longitude: -118.278921))
    static let village = Pin(title: "The Village", coordinate: CLLocationCoordinate2D(latitude: 34.0254451, longitude: -118.285224))
    static let zo = Pin(title: "The Lorenzo", coordinate: CLLocationCoordinate2D(latitude: 34.0284157, longitude: -118.272838))
    static let cc = Pin(title: "Campus Center", coordinate: CLLocationCoordinate2D(latitude: 34.0201376, longitude: -118.2864465))
    static let doheny = Pin(title: "Doheny Library", coordinate: CLLocationCoordinate2D(latitude: 34.0201, longitude: -118.2837))
    static let parkside = Pin(title: "Parkside", coordinate: CLLocationCoordinate2D(latitude: 34.0189409, longitude: -118.2910119))
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
