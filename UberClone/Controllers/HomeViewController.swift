//
//  HomeViewController.swift
//  UberClone
//
//  Created by mac on 11/4/20.
//

import UIKit
import Firebase
import MapKit



class HomeViewController: UIViewController {
	
	//MARK: Properties
	private let mapView 		= MKMapView()
	private let locationManager = CLLocationManager()
	private	let inputViews		= InputView()
	private let menuIcon        = UIButton.init(SFSymbols.menu)
	private let locationInputView = ShowLocationInputView()
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		checkIfUserLoggedIn()
//		signOut()
		setupNavigation()
		creatUI()
		enableLocationAuthorition()
	}
}

//MARK: Service Firebase
extension HomeViewController {
	fileprivate func checkIfUserLoggedIn() {

		if Auth.auth().currentUser?.uid == nil {
				let loginController = UINavigationController(rootViewController: LoginController())
				loginController.modalPresentationStyle = .overFullScreen
				present(loginController, animated: true)
		} else {
			creatUI()
		}
	}
	
	fileprivate func signOut() {
		do {
			try Auth.auth().signOut()
		} catch let signOutError {
			print("Having Trobble with SignOut the usr", separator: "resons:", terminator: "\(signOutError)")
		}
	}
}

//MARK:  setup Create UI with MapView
extension HomeViewController: InputViewDelegate,LocationInputViewDelegate {
	
	
	
	func setupNavigation() {
		view.backgroundColor = .niceBlue
		navigationController?.navigationBar.isHidden = true
	}
	func creatUI() {
		//Add MapView
		view.addSubview(mapView)
		mapView.frame = view.frame
		
		//Add menu icon to the Map
		mapView.addSubview(menuIcon)
		menuIcon.anchor(top: mapView.safeAreaLayoutGuide.topAnchor, leading: mapView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 15, bottom: 0, right: 0))
		
		
		mapView.addSubview(inputViews)
		inputViews.anchor(top: menuIcon.bottomAnchor, leading: mapView.leadingAnchor, bottom: nil, trailing: mapView.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
		inputViews.constrainHeight(constant: 50)
		
		inputViews.delegate = self
		
		//Animate InputView
		inputViews.alpha = 0
		UIView.animate(withDuration: 2) {
			self.inputViews.alpha = 1
		}
		// Showing User Location in the Map
		showUserLocationInMap()
		
	
		
	}
	func setupLocationInputUI() {
		mapView.addSubview(locationInputView)
		locationInputView.anchor(top: mapView.topAnchor, leading: mapView.leadingAnchor, bottom: nil, trailing: mapView.trailingAnchor, size: .init(width: 0, height: 200))
		locationInputView.delegate = self
		locationInputView.alpha = 0
		UIView.animate(withDuration: 0.3) {
			self.locationInputView.alpha = 1
		} completion: { (_) in
			print("Presting Table View...")
		}

	}
	fileprivate func showUserLocationInMap() {
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
	}
	func prestenLocationInputView() {
		setupLocationInputUI()
	}
	func dismissLocationInputView() {
		UIView.animate(withDuration: 0.3) {
			self.locationInputView.alpha = 0
		} completion: { (_) in
			UIView.animate(withDuration: 2) {
				self.inputViews.alpha = 1
			}
		}

	}
}

//MARK:  LoactionService
extension HomeViewController: CLLocationManagerDelegate {
	
	func enableLocationAuthorition() {
		locationManager.delegate = self
		switch locationManager.authorizationStatus {
		case .notDetermined:
			print("Not Determined")
			locationManager.requestWhenInUseAuthorization()
		case .restricted,.denied:
			print("user denied")
		case .authorizedAlways:
			print("authorize")
			locationManager.stopUpdatingLocation()
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
		case .authorizedWhenInUse:
			print(" When in use authorize")
			locationManager.requestAlwaysAuthorization()
		@unknown default:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.requestAlwaysAuthorization()
		}
	}
}
