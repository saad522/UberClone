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
	
	private let mapView 		   = MKMapView()
	private let locationManager    = LocationService.shared.locationManager
	private	let inputViews		   = InputView()
	private let menuIcon           = UIButton.init(SFSymbols.menu)
	private let locationInputView  = ShowLocationInputView()
	private let tableView		   = UITableView()
	private let cellID			   = "cellID"
	private let annotationDriverID = "annotationDriverID"
	private let heightOfLocationInputView : CGFloat = 200
	var user : User? {
		didSet {
			self.locationInputView.user = user
		}
	}
	
	
	
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		checkIfUserLoggedIn()
		//		signOut()
		setupNavigation()
		//		creatUI()
		enableLocationAuthorition()
		fetchUser()
		fetchDriverData()
	}
	
}

//MARK: Service Firebase
extension HomeViewController {
	
	func fetchDriverData() {
		guard let location = locationManager?.location else { return }
		Service.shared.fetchDriverData(with: location) { (driver) in
			guard let coordinate = driver.location?.coordinate else { return }
			let annotation = DriverAnnotaion(uid: driver.uid, coordinate: coordinate)
			print("Driver Coordinate : \(coordinate)")
			var driverIsVisible : Bool {
				return self.mapView.annotations.contains { annotation -> Bool in
					guard let driverAnnotaion = annotation as? DriverAnnotaion else  { return false }
						if driverAnnotaion.uid == driver.uid {
							driverAnnotaion.updateDriverCoordinate(coordinate: coordinate)
							return true
						}
					return false
				}
			}
			if !driverIsVisible {
				self.mapView.addAnnotation(annotation)
			}
			
		}
	}
	func fetchUser() {
		guard let userId = Auth.auth().currentUser?.uid else { return }
		Service.shared.fetchUserData(with: userId) { (user) in
			self.user = user
		}
	}
	
	fileprivate func checkIfUserLoggedIn() {
		if Auth.auth().currentUser?.uid == nil {
			let loginController = LoginController()
			loginController.homeController = self
			let controller = UINavigationController(rootViewController: loginController)
			controller.modalPresentationStyle = .overFullScreen
			present(controller, animated: true)
		} else {
			creatUI()
			fetchUser()
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
//MARK: setup TableView
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 0 ? 2 : 5
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return section == 0 ? "Recente" : "Result"
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
		return cell
	}
	
	fileprivate func configuTablrView() {
		tableView.register(TableViewCell.self, forCellReuseIdentifier: cellID)
		tableView.rowHeight	 = 60
		tableView.delegate 	 = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		let height			 = view.frame.height - heightOfLocationInputView
		tableView.frame		 = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
		view.addSubview(tableView)
	}
}
//MARK: setup MapView
extension HomeViewController : MKMapViewDelegate {
	fileprivate func showUserLocationInMap() {
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
		mapView.delegate = self
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? DriverAnnotaion {
			let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationDriverID)
			view.image = #imageLiteral(resourceName: "chevron-sign-to-right")
			return view
		}
		return nil
	}
}
//MARK:  setup Create UI
extension HomeViewController: InputViewDelegate,LocationInputViewDelegate {
	
	func setupNavigation() {
		view.backgroundColor = .niceBlue
		navigationController?.navigationBar.isHidden = true
	}
	func creatUI() {
		//Add MapView
		view.addSubview(mapView)
		mapView.frame 	 = view.frame
		
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
		//Showing User Location in the Map
		showUserLocationInMap()
		
		
	}
	func setupLocationInputUI() {
		view.addSubview(locationInputView)
		locationInputView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 199))
		locationInputView.delegate = self
		locationInputView.alpha = 0
		UIView.animate(withDuration: 0.3) {
			self.locationInputView.alpha = 1
		} completion: { (_) in
			//TableView
			UIView.animate(withDuration: 1) {
				self.tableView.frame.origin.y = self.heightOfLocationInputView
				print("Presting Table View...")
			}
		}
		
	}
	
	func prestenLocationInputView() {
		inputViews.alpha = 0
		setupLocationInputUI()
		configuTablrView()
	}
	func dismissLocationInputView() {
		locationInputView.removeFromSuperview()
		UIView.animate(withDuration: 0.3) {
			self.locationInputView.alpha = 0
			self.tableView.frame.origin.y = self.view.frame.height
		} completion: { (_) in
			UIView.animate(withDuration: 0.9) {
				self.inputViews.alpha = 1
			}
		}
	}
}

//MARK:  LoactionService
extension HomeViewController {
	func enableLocationAuthorition() {
		switch locationManager?.authorizationStatus {
		case .notDetermined:
			print("Not Determined")
			locationManager?.requestWhenInUseAuthorization()
		case .restricted,.denied:
			print("user denied")
		case .authorizedAlways:
			print("authorize")
			locationManager?.stopUpdatingLocation()
			locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		case .authorizedWhenInUse:
			print(" When in use authorize")
			locationManager?.requestAlwaysAuthorization()
		case .none:
			break
		@unknown default:
			break
		}
	}
	
	
}
