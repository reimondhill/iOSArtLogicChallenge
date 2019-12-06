//
//  ApiManager.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation

protocol ApiManaging {
    var token: String { get }
    func getHeadlines(completion:@escaping (Result<[CollectionItem], Error>)->Void)
}

enum ApiManagerError:Error{
    case noResponse
}

class ApiManager: NSObject {
    
    //MARK:- Properties
    //MARK: Constants
    let network:Network
    
    //MARK:- Constructor
    required init(network:Network){
        
        self.network = network
        super.init()
        
    }
    
}

//MARK:- Public methods
extension ApiManager: ApiManaging {
    
    var token: String { return "feca0f24c0724208ac102c17592243a1" }
    
    func getHeadlines(completion: @escaping (Result<[CollectionItem], Error>) -> Void) {
        
        guard let url = URL(string: network.artworks) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
    
        network.fetchCodable(url: url, method: .post, params: ["token":token], completion: { (result: Result<CollectionResponse, Error>) in
            
            switch result {
            case .success(let collectionResponse):
                completion(.success(collectionResponse.collectionItems))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    
    }
        
}
