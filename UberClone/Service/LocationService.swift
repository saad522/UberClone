//
//  LocationService.swift
//  UberClone
//
//  Created by mac on 11/7/20.
//

import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {
	
	static let shared = LocationService()
	var locationManager : CLLocationManager!
	var location : CLLocation?
	
	override init() {
		super.init()
		locationManager = CLLocationManager()
		locationManager.delegate = self
	}
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.requestAlwaysAuthorization()
		}
	}
}
