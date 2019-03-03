//
//  UIView+Extensions.swift
//  Moon
//
//  Created by Kevin Wang on 1/23/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import UIKit

struct ViewExtensionConstants {
    static let CornerRadius : CGFloat = 5
}

// MARK: - View appearance extensions
extension UIView {
    func roundEdges() {
        self.layer.cornerRadius = ViewExtensionConstants.CornerRadius
        self.layer.masksToBounds = true 
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.clipsToBounds = true 
    }
}

// MARK: - View animation extensions

extension UIView {
    func hideOver(duration : TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.alpha = 0
        }, completion: nil)
    }
    
    func showOver(duration : TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.alpha = 1
        }, completion: nil)
    }
    
    static func animateWith(animationHandler : @escaping () -> Void, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: animationHandler, completion: nil)
    }
    
}
