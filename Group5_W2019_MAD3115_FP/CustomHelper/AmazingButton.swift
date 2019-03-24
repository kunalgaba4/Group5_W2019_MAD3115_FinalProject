//
//  AmazingButton.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-16.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit
class AmazingButton: UIButton {
    var cornerRadius: CGFloat = 2.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            layer.cornerRadius = 15.0
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.red.cgColor
        }
    }
}
