//
//  InputView.swift
//  UberClone
//
//  Created by mac on 11/5/20.
//

import UIKit
protocol InputViewDelegate : class {
	func prestenLocationInputView()
}

class InputView: UIView {
	//MARK: Properties
	private let indicatore = UIView(.label, 8)
	private let whereToLabel = UILabel.init(text: "Where to?", font: UIFont(name: "HelveticaNeue-Bold", size: 16)!, textColor: .systemGray)
	
	weak var delegate : InputViewDelegate?
	//MARK: LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		creatUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: Create UI
extension InputView {
	func creatUI() {
		addShadow()
		backgroundColor = .systemBackground
		
		let hStack = HStackView(arrangedSubviews: [indicatore,whereToLabel],spacing: 10)
		addSubview(hStack)
		hStack.fillSuperview(padding: .init(top: 0, left: 15, bottom: 0, right: 0))
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handlePresntInputView))
		addGestureRecognizer(tap)
	}
	
	@objc func handlePresntInputView() {
		delegate?.prestenLocationInputView()
	}
}
