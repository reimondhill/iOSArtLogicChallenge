//
//  PresentationResponse.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


class PresentationResponse: Codable {
    
    let galleryName: String
    let searchText: String
    let presentationItems: [PresentationItem]
    
    enum CodingKeys: String, CodingKey {
        case galleryName = "gallery_name"
        case searchText = "search_text"
        case presentationItems = "rows"
    }
    
}
