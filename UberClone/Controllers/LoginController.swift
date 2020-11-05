//
//  LoginController.swift
//  UberClone
//
//  Created by mac on 10/9/20.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //MARK: Properties
    let logo = UILabel(text: "UBER", font: UIFont(name: "Avenir-Light", size: 36)!,textColor: UIColor(white: 1, alpha: 0.8))
    
    let emailText    = UITextField(placholder: "Email")
    let passwordText = UITextField(placholder: " Password",isPassword: true)
    
    let iconEmail    = UIImageView(SFSymbols.email)
    let iconPassword = UIImageView(SFSymbols.password)
    
    let separatorEmail       = UIView(.lightGray)
    let separatorPassword    = UIView(.lightGray)
    
    
    let logButton = UIButton(title : "Log in")
    
    let signButton = UIButton("Don't have an account?", "Sign up")
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGroundColor
        dismissKeyBoard()
        creatUI()
        actions()
        configNavigationController()
    }
}

//MARK: Service Firebase Login User
extension LoginController {
	@objc fileprivate func login() {
		guard let email	   = emailText.text else { return }
		guard let password = passwordText.text else { return }
		
		Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
			if let error = error {
				print("Failed to Lgin with user resons :",error.localizedDescription)
				return
			}
//			let homeController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? 		HomeViewController
//			homeController?.creatUI()
			self.dismiss(animated: true)
			print("Alright Alright Alright user login 👍🏼")
		}
	}
}


//MARK: Handle Actions
extension LoginController {
    fileprivate func actions() {
        signButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
		logButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func handleSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
        
    }
}


//MARK: Creat Usert Interface
extension LoginController {
    fileprivate func configNavigationController() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    fileprivate func creatUI() {
        
        view.addSubview(logo)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                    leading: view.centerXAnchor,
                    bottom: nil, trailing: nil,
                    padding: .init(top: 15, left: -45, bottom: 0, right: 0))
        
        
        
        let HStackEmail    = HStackView(arrangedSubviews: [iconEmail,UIView(),emailText,UIView()])
        let VStackEmail    = VerticalStackView(arrangedSubviews: [HStackEmail,separatorEmail], spacing: 10)
        
        let HStackPassword = HStackView(arrangedSubviews: [iconPassword,UIView(),passwordText,UIView()])
        let VStackPassword = VerticalStackView(arrangedSubviews: [HStackPassword,separatorPassword], spacing: 10)
        
        let mainStack      = VerticalStackView(arrangedSubviews: [VStackEmail,VStackPassword,logButton], spacing: 40)
        
        view.addSubview(mainStack)
        mainStack.anchor(top: logo.safeAreaLayoutGuide.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 25, left: 25, bottom: 0, right: 25))
        
        view.addSubview(signButton)
        signButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    fileprivate func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
}

