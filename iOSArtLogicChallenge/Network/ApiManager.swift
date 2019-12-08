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
    var collectionsDidRefresh: ((Result<[CollectionItem], Error>) -> Void)? { get set }
    func startCollectionsRefresh()
    func stopCollectionsRefresh()
    func getCollections(completion:@escaping (Result<[CollectionItem], Error>)->Void)
    func getPresentation(uid: String, completion:@escaping (Result<PresentationResponse, Error>)->Void)
}

enum ApiManagerError:Error{
    case noResponse
}

class ApiManager: NSObject {
    
    //MARK:- Properties
    //MARK: Constants
    let network:Network
    private let baseURL = "https://artlogicdevelopertest.privateviews.com/api/browse/all"
    private var timer: Timer?
    private var _collectionsDidRefresh: ((Result<[CollectionItem], Error>) -> Void)?
    
    //MARK:- Constructor
    required init(network:Network){
        
        self.network = network
        super.init()
        
    }
    
}

//MARK:- Public methods
extension ApiManager: ApiManaging {
    
    var token: String { return "feca0f24c0724208ac102c17592243a1" }
    
    var collectionsDidRefresh: ((Result<[CollectionItem], Error>) -> Void)? {
        get {
            return _collectionsDidRefresh
        }
        set {
            _collectionsDidRefresh = newValue
        }
    }
    
    func startCollectionsRefresh() {
        timer = Timer.scheduledTimer(withTimeInterval: (5 * 60), repeats: true, block: { [weak self] (timer) in
            guard let strongSelf = self else { return }
            
            print(strongSelf.logClassName, "Updating collections")
            strongSelf.getCollections { (result) in
                strongSelf.collectionsDidRefresh?(result)
            }
            
        })
    }
    
    func stopCollectionsRefresh() {
        timer?.invalidate()
        timer = nil
    }
    
    func getCollections(completion: @escaping (Result<[CollectionItem], Error>) -> Void) {
        
        guard let url = URL(string: baseURL) else {
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
        
    func getPresentation(uid: String, completion: @escaping (Result<PresentationResponse, Error>) -> Void) {
        
        let presetationExtended = baseURL.appending("/\(uid)")
        guard let url = URL(string: presetationExtended) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        network.fetchCodable(url: url, method: .post, params: ["token":token], completion: { (result: Result<PresentationResponse, Error>) in
            
            switch result {
            case .success(let presentationResponse):
                completion(.success(presentationResponse))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
        
    }
    
}
