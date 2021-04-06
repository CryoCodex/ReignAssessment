//
//  Extensions.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation

// MARK: Core Data
extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

// MARK: Fatal Errors
enum CodableErrors: Error {
    case missingManagedObjectContext
}
