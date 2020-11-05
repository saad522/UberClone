//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/14/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1,textColor : UIColor = .black) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}
extension UITextField {
    convenience init(placholder : String,font : UIFont = .systemFont(ofSize: 16),placeHolderColor : UIColor = .lightGray,borderStyle : BorderStyle = .none,textColor : UIColor = .white,isPassword : Bool = false) {
        self.init(frame : .zero)
        self.attributedPlaceholder = NSAttributedString(string: "\(placholder)", attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])
        self.font = font
        self.borderStyle = borderStyle
        self.textColor = textColor
        self.isSecureTextEntry = isPassword
        self.keyboardAppearance = .dark
    }
}
extension UIImageView {
    convenience init(_ icone : String) {
        self.init(frame:.zero)
        self.image = UIImage(systemName: "\(icone)",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large))?.withRenderingMode(.alwaysTemplate)
        self.tintColor = .white
    }
}
extension UIView {
	convenience init(backgroundColor : UIColor) {
		self.init(frame:.zero)
		self.backgroundColor = backgroundColor

	}
}
extension UIView {
	convenience init(_ lineH : CGFloat,_ lineW : CGFloat) {
		self.init(frame:.zero)
		self.backgroundColor = .label
		self.constrainHeight(constant: lineH)
		self.constrainWidth(constant: lineW)

	}
}
extension UIView {
	convenience init(_ color : UIColor = .label,_ boxSize : CGFloat = 6) {
		self.init(frame:.zero)
		self.backgroundColor = color
		self.constrainHeight(constant: boxSize)
		self.constrainWidth(constant: boxSize)
	}
}
extension UIView {
	convenience init(_ box : CGFloat = 6) {
		self.init(frame:.zero)
		self.backgroundColor = .label
		self.constrainHeight(constant: box)
		self.constrainWidth(constant: box)
	}
}
extension UIView {
	func addShadow() {
		layer.shadowOpacity = 0.5
		layer.shadowRadius  = 10
		layer.shadowOffset  = .init(width: 0, height: 10)
		layer.cornerRadius  = 5
	}
}
extension UIView {
    convenience init(_ color : UIColor = .lightGray) {
        self.init(frame:.zero)
        self.backgroundColor = color
        self.constrainHeight(constant: 1)
    }
}
extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
	convenience init(_ icon: String,size : CGFloat = 20,color : UIColor = .label) {
		self.init(type: .system)
		self.tintColor = color
		let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .semibold, scale: .large)
		self.setImage(UIImage(systemName: icon, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate), for: .normal)
	}
}
extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.secondarySystemBackground, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 25)
        self.layer.cornerRadius = 6
        self.backgroundColor = .niceBlue
    }
}
extension UIButton {
    convenience init(_ message : String, _ action : String) {
        self.init(type: .system)
        let attribudeTitle = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        attribudeTitle.append(NSAttributedString(string: action, attributes:
            [NSAttributedString.Key.foregroundColor : UIColor.niceBlue,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]))
        self.setAttributedTitle(attribudeTitle, for: .normal)
    }
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return .init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backGroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let niceBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
}

