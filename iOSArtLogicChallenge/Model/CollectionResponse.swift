//
//  ArtworkCollection.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


class CollectionResponse: Codable {

    let collectionItems: [CollectionItem]
    
    enum CodingKeys: String, CodingKey {
        case collectionItems = "rows"
    }
}


