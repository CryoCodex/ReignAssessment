//
//  NetworkLayer.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation
import Alamofire

class NetworkLayer {
    
    func fetchData<T: Codable>(baseClass: T.Type, path: String, method: HTTPMethod, parameters: [String: String], resultBlock: @escaping(Result<T, NSError>) -> Void){
        
        AF.request(path,
                   method: method,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .validate(statusCode: 200 ..< 600)
            .responseJSON { (server) in
                let statusCode = server.response?.statusCode ?? 600
                
                switch statusCode {
                case 200 ..< 300:
                    
                    guard let jsonResponse = try? server.result.get() else {
                        print("Failure getting JSON Response")
                        resultBlock(.failure(NSError()))
                        return
                    }
                    
                    guard let serializedJSON = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                        print("Failure serializing JSON Response")
                        resultBlock(.failure(NSError()))
                        return
                    }
                    
                    guard let genObject = try? JSONDecoder().decode(T.self, from: serializedJSON) else {
                        print("Failure decoding JSON Response")
                        resultBlock(.failure(NSError()))
                        return
                    }
                    
                    resultBlock(.success(genObject))
                    
                default:
                    print("Invalid status code")
                    resultBlock(.failure(NSError()))
                }
            
            }
    }
    
    
}
