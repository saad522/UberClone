//
//  HStackView.swift
//  UberClone
//
//  Created by mac on 10/9/20.
//

import UIKit

class HStackView: UIStackView {
    init(arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = 5
        self.axis = .horizontal
        self.alignment = .center
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
