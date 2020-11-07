//
//  TableViewCell.swift
//  UberClone
//
//  Created by mac on 11/6/20.
//

import UIKit


class TableViewCell: UITableViewCell {
	//MARK:Properties
	let adress = UILabel(text: "Coffe Shope", font: .systemFont(ofSize: 16, weight: .semibold))
	let fullAdress = UILabel.init(text: "Los Angles Street N°13", font: .systemFont(ofSize: 14, weight: .light),textColor: .lightGray)
	
	//MARK: LifeCycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		createUI()
	}
	
	fileprivate func createUI() {
		selectionStyle = .none
		let stack = VerticalStackView(arrangedSubviews: [adress,fullAdress], spacing: 5)
		let hStack = HStackView(arrangedSubviews: [UIView(),UIView(),stack])
		addSubview(hStack)
		hStack.centerYInSuperview()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
