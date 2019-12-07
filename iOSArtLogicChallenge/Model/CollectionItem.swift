//
//  CollectionItem.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


class CollectionItem: Codable {
    let uid:String
    let caption:String
    let images: ImageSet?
}
