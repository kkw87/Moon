//
//  UIColor+Extensions.swift
//  Moon
//
//  Created by Kevin Wang on 1/23/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public class var textFieldBackgroundColor : UIColor {
        return UIColor.white.withAlphaComponent(0.8)
    }
    
    public class var invalidTextFieldBackgroundColor : UIColor {
        return UIColor.red.withAlphaComponent(0.45)
    }
}
