//
//  SignUpController.swift
//  UberClone
//
//  Created by mac on 10/10/20.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    //MARK: Properties
    let logo         = UILabel(text: "UBER", font: UIFont(name: "Avenir-Light", size: 36)!,
                               textColor: UIColor(white: 1, alpha: 0.8))
    
    let emailText    = UITextField(placholder : "Email")
    let passwordText = UITextField(placholder : "Password",isPassword: true)
    let fullNameText = UITextField(placholder : "Full Name")
    
    let iconEmail    = UIImageView(SFSymbols.email)
    let iconPassword = UIImageView(SFSymbols.password)
    let iconFullName = UIImageView(SFSymbols.persone)
    let iconType     = UIImageView(SFSymbols.type)
    
    let lineEmail    = UIView(.lightGray)
    let linePassword = UIView(.lightGray)
    let lineFullName = UIView(.lightGray)
    let lineUserType = UIView(.lightGray)
    
    let signUpButton = UIButton(title : "Sign Up")
    let loginButton  = UIButton("Already have an account?","Log in")
    
    let userType : UISegmentedControl  = {
        let segmented                  = UISegmentedControl(items : ["Rider","Driver"])
        segmented.backgroundColor      = .backGroundColor
        segmented.tintColor            = UIColor.init(white: 1, alpha: 0.07)
        segmented.selectedSegmentIndex = 1
        return segmented
    }()
 
    //MARK: Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .backGroundColor
        createUI()
        dismissKeyBoard( )
        loginAction()
    }
}

//MARK: Create User Interface
extension SignUpController {
    fileprivate func createUI() {
        
        view.addSubview(logo)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.centerXAnchor, bottom: nil, trailing: nil,padding: .init(top: 15, left: -45, bottom: 0, right: 0))
        
        //Email Stack
        let hStackEmail    = HStackView(arrangedSubviews: [iconEmail,UIView(),emailText,UIView()])
        let vStackEmail    = VerticalStackView(arrangedSubviews: [hStackEmail,lineEmail], spacing: 10)
        
        //FullName Stack
        let hStackFullName = HStackView(arrangedSubviews: [iconFullName,UIView(),fullNameText,UIView()])
        let vStackFullName = VerticalStackView(arrangedSubviews: [hStackFullName,lineFullName], spacing: 10)
        
        //Password Stack
        let hstackPassword = HStackView(arrangedSubviews: [iconPassword,UIView(),passwordText,UIView()])
        let vStackPassword = VerticalStackView(arrangedSubviews: [hstackPassword,linePassword], spacing: 10)
        
        // User Type Stack
        let hStackUserType = HStackView(arrangedSubviews: [iconType,UIView()])
        let vStackUserType = VerticalStackView(arrangedSubviews: [hStackUserType,userType,lineUserType], spacing: 10)
        
        //Main StackView
        let  stackView     = VerticalStackView(arrangedSubviews: [vStackEmail,vStackFullName,vStackPassword,vStackUserType,signUpButton], spacing: 40)
        
        view.addSubview(stackView)
        stackView.anchor(top: logo.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
        
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
    }
}

//MARK: Service Firebase Create User
extension SignUpController {
	@objc fileprivate func createUser()  {
		
		guard let email    = emailText.text    else { return }
		guard let password = passwordText.text else { return }
		guard let fullName = fullNameText.text else { return }
		let accounteType = userType.selectedSegmentIndex
		
		Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
			if let error = error {
				print("Error with Emil or Password resaon : ",error.localizedDescription )
				return
			}
			
			guard let uid = result?.user.uid else { return }
			let values = ["Email":email,"Full-Name":fullName,"AccounteType":accounteType,"Password":password] as [String : Any]
			
			Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
				if let error = error {
					print("Error with Update Users Data reason : ",error.localizedDescription)
					return
				}
//				let homeController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? 			HomeViewController
//				homeController?.creatUI()
				self.dismiss(animated: true)
				print("Alright alright alright we did it 💪🏼")
			}
		}
	}
}



//MARK: Handle Actions
extension SignUpController {
    fileprivate func loginAction() {
        loginButton.addTarget(self, action: #selector(handleDismisseController), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(createUser), for: .touchUpInside)
    }
    @objc fileprivate func handleDismisseController() {
        navigationController?.popViewController(animated: true)
    }
    fileprivate func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
