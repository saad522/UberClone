//
//  Service.swift
//  UberClone
//
//  Created by mac on 11/7/20.
//

import Firebase

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
	
	func fetchUserData(completion : @escaping(User) -> Void) {
//		guard let uid = userId else { return }
		guard let userId = Auth.auth().currentUser?.uid else { return }
		REF_USERS.child(userId).observeSingleEvent(of: .value) { (snpachot) in
			guard let dictionary = snpachot.value as? [String:Any] else {return}
			let user = User(dectionary: dictionary)
			completion(user)
		}
	}
}
