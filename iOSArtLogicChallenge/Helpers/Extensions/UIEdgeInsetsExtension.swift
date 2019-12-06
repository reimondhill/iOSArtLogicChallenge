//
//  UIEdgeInsetsExtension.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit


extension UIEdgeInsets{
    
    /// Inits with a global padding
    /// - Parameters:
    ///   - Padding: Inset for top, right, bottom, left
    init(padding:CGFloat) {
        self.init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
}
