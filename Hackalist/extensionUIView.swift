//
//  extensionUIView.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/20/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation
import UIKit




//MARK: Animation extension.
extension UIView {
    
    func animateButtonDown() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func animateButtonUp() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
}


}
