//
//  DriverAnnotaion.swift
//  UberClone
//
//  Created by mac on 11/9/20.
//

import MapKit


class DriverAnnotaion: NSObject, MKAnnotation {
	dynamic var coordinate : CLLocationCoordinate2D
	var uid 	   : String
	
	init(uid : String, coordinate : CLLocationCoordinate2D) {
		self.uid = uid
		self.coordinate = coordinate
	}
	
	func updateDriverCoordinate(coordinate : CLLocationCoordinate2D) {
		UIView.animate(withDuration: 0.2) {
			self.coordinate = coordinate
		}
	}
}
