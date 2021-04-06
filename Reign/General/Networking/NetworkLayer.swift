//
//  NetworkLayer.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation
import Alamofire

class NetworkLayer {
    
    func fetchData<T: Decodable>(baseClass: T.Type, path: String, method: HTTPMethod, parameters: [String: String], resultBlock: @escaping(Result<T, NSError>) -> Void){
        
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
                    
                    var genObject: T
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        // Since we are using the same Core Data Model class we need to pass
                        // the context to the decoder in order to comply with the initializer
                        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
                        genObject = try decoder.decode(T.self, from: serializedJSON)
                    
                    } catch {
                        let error = error as NSError
                        print(error)
                        resultBlock(.failure(error))
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
