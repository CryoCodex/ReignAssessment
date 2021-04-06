//
//  API.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation

class API {
    
    private static let API_URL = "API_URL"
    
    static var mainDict: [String: Any] {
        get {
            guard let mainDict = Bundle.main.infoDictionary else {
                print("Couldn't open main Info.plist dictionary")
                return [:]
            }
            
            return mainDict
        }
    }
    
    static var apiUrl: String {
        get {
            return mainDict[API_URL] as? String ?? ""
        }
    }
    
    // MARK: Modules
    struct Home {
        enum HomePaths {
            case list
        }
        
        static func getPath(for type: HomePaths) -> String {
            var path = ""
            
            switch type {
            case .list:
                path += "/search_by_date"
                break
            }
            
            return API.apiUrl + path
        }
    }
    
}
