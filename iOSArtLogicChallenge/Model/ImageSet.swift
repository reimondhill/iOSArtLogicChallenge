//
//  ImageSet.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation

class ImageSet: Codable {
    let defaultImage: String?
    let desktop: String?
    let desktopThumbnail: String?
    //Ignored email
    let fullSize: String?
    //Ignored HighRes
    let ipad: String?
    let master: String?
    let mobile: String?
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case defaultImage = "default"
        case desktop
        case desktopThumbnail = "desktop-thumbnail"
        case fullSize = "full_size"
        case ipad
        case master
        case mobile
        case thumbnail
    }
}
