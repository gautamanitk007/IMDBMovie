//
//  RoundedView.swift
//  Movie
//
//  Created by Gautam Singh on 5/12/21.
//

import UIKit
class RoundedView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 6.0
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}
