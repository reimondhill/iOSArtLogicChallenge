//
//  PresentationItem.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


class PresentationItem: Codable {
    let caption: String
    let imageSet: ImageSet
    
    enum CodingKeys: String, CodingKey {
        case caption
        case imageSet = "images"
    }
    
}
