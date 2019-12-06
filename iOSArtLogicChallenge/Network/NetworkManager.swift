//
//  NetworkManager.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


class NetworkManager: NSObject, Network {
    
    var artworks: String {
        return "https://artlogicdevelopertest.privateviews.com/api/browse/all"
    }
    
    func fetchCodable<T>(url:URL, method: RequestType, params: [String: Any], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        var urlRequest = URLRequest(url: url)
        
        switch method {
        case .get:
            //TODO in the future
            break
        case .post:
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = getPostString(params: params).data(using: .utf8)
        }
        performRequest(urlRequest) { (result) in
            
            switch result{
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                }
                catch let decodeError{
                    completion(.failure(decodeError))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }

}


//MARK: - Private methods
private extension NetworkManager {
    
    func performRequest(_ urlRequest: URLRequest, completion: @escaping ((Result<Data, Error>)->Void) ){
        
        guard urlRequest.url != nil else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let urlSession = URLSession(configuration: sessionConfig)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode else{
                    
                    completion(.failure(NetworkError.dataCorrupted))
                    return
                    
            }
            
            
            print(String(decoding: data, as: UTF8.self))
            
            completion(.success(data))
            
        }.resume()
        
    }
    
    func getPostString(params: [String: Any]) -> String {
        var data = [String]()
        
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        
        return data.map { String($0) }.joined(separator: "&")
    }
    
}
