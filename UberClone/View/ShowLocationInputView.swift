//
//  ShowLocationInputView.swift
//  UberClone
//
//  Created by mac on 11/5/20.
//

import UIKit
protocol LocationInputViewDelegate: class {
	func dismissLocationInputView()
}
class ShowLocationInputView: UIView {
	
	//MARK: Properties
	weak var delegate : LocationInputViewDelegate?
	private let backButton 		 = UIButton(SFSymbols.back)
	private let firstName  		 = UILabel.init(text: "Bruce Wayne", font: UIFont(name: "HelveticaNeue-Bold", size: 16)!)
	private let indicatoreGreen  = UIView(.systemGreen,6)
	private let indicatoreBlack  = UIView(.label,10)
	private let blackLine = UIView(20, 1)
	private let containerOne    = UIView(backgroundColor: .secondarySystemBackground)
	private let containerTwo    = UIView(backgroundColor: .systemFill)
	private let currentLocationLabel = UITextField.init(placholder: "Current Location.",textColor: .label)
	private let whereToLabel = UITextField.init(placholder: "Enter a destination.",textColor: .label)
	
	
	//MARK: LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		createUI()
		setActions()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


//MARK: Create UI
extension ShowLocationInputView {
	
	fileprivate func createUI() {
		addShadow()
		backgroundColor = .systemBackground
		let hStackTop = HStackView(arrangedSubviews: [backButton,UIView(),firstName], spacing: 40)
		hStackTop.distribution = .fillProportionally
		addSubview(hStackTop)
		hStackTop.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15))
		
		containerOne.addSubview(currentLocationLabel)
		currentLocationLabel.fillSuperview(padding: .init(top: 0, left: 15, bottom: 0, right: 0))
		currentLocationLabel.isEnabled = false
		containerTwo.addSubview(whereToLabel)
		whereToLabel.fillSuperview(padding: .init(top: 0, left: 15, bottom: 0, right: 0))
		
		let vStack = VerticalStackView(arrangedSubviews: [containerOne,containerTwo], spacing: 5)
		vStack.distribution = .fillEqually
		vStack.constrainHeight(constant: 80)
		
		let vStackLines = VerticalStackView(arrangedSubviews: [indicatoreGreen,blackLine,indicatoreBlack], spacing: 5)
		vStackLines.alignment = .center

		addSubview(vStack)
		vStack.anchor(top: hStackTop.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 15, left: 25, bottom: 0, right: 25))
		
		addSubview(vStackLines)
		vStackLines.anchor(top: vStack.topAnchor, leading: leadingAnchor, bottom: nil, trailing: vStack.leadingAnchor,padding: .init(top: 15, left: 5, bottom: 0, right: 5))
	
	}
	func setActions() {
		backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
	}
	
	@objc func handleBackButton() {
		delegate?.dismissLocationInputView()
	}
}
