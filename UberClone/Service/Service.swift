//
//  Service.swift
//  UberClone
//
//  Created by mac on 11/7/20.
//

import Firebase
import CoreLocation
import GeoFire

enum ChildType {
	static let USERS   = "users"
	static let DRIVRES = "drives-Location"
}


let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child(ChildType.USERS)
let REF_DRIVE_LOCATIONS = DB_REF.child(ChildType.DRIVRES)


class Service {
	static let shared = Service()
	let userId = Auth.auth().currentUser?.uid
	
	func fetchUserData(with userId : String,completion : @escaping(User) -> Void) {		
		REF_USERS.child(userId).observeSingleEvent(of: .value) { (snpachot) in
			guard let dictionary = snpachot.value as? [String:Any] else {return}
			let uid = snpachot.key
			let user = User(uid: uid, dectionary: dictionary)
			completion(user)
		}
	}
	
	func fetchDriverData(with location : CLLocation,completion : @escaping(User) -> Void) {
		let geoFire = GeoFire(firebaseRef: REF_DRIVE_LOCATIONS)
		REF_DRIVE_LOCATIONS.observe(.value) { (snpashot) in
			geoFire.query(at: location, withRadius: 50).observe(.keyEntered, with : { (uid, location) in
				self.fetchUserData(with: uid) { (user) in
					var driver = user
					driver.location = location
					completion(driver)
				}
			})
		}
		
	}
}
