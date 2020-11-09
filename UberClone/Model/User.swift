//
//  User.swift
//  UberClone
//
//  Created by mac on 11/7/20.
//

import CoreLocation

struct User {
	let fullName    : String
	let email       : String
	let accountType : Int
	let uid 		: String
	var location 	: CLLocation?
	
	init(uid : String, dectionary : [String : Any]) {
		self.fullName 	 = dectionary["Full-Name"] as? String ?? ""
		self.email   	 = dectionary["Email"] as? String ?? ""
		self.accountType = dectionary["AccounteType"] as? Int ?? 0
		self.uid 		 = uid
	}
	
}
