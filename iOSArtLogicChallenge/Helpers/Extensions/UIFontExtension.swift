//
//  UIFontExtension.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 08/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit


extension UIFont {
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size)!
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
    
}
