//
//  Network.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


enum NetworkError:Error {
    case dataCorrupted
    case invalidURL
}

enum RequestType:String{
    case get = "GET"
    case post = "POST"
}

protocol NetworkURL {
    ///StringURL for fetching headlines
    var artworks:String{ get }

}

protocol Network:NetworkURL {
    
    /// Perform GET/POST request returning the result decoded object
    ///
    /// - Parameters:
    ///   - urlRequest: Url request with the request config
    ///   - completion: Result type handler called the request has finished.
    func fetchCodable<T:Codable>(url:URL, method: RequestType, params: [String:Any], completion:@escaping (Result<T,Error>)->Void)
    
}
