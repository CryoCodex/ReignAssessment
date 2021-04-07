//
//  Extensions.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

// MARK: - CoreData related operations
extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

// MARK: - Fatal Errors
enum CodableErrors: Error {
    case missingManagedObjectContext
    case missingEntityDescription
}

// MARK: - UITableView
extension UITableView {
    
    //This method allow to register cells ONLY of the
    //.xib and the cell class has the same name
    func registerCell(named: String) {
        let identifier = named
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}

// MARK: - Array
extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

// MARK: - UIView
extension UIView {
    func fadeIn(at duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 1
        }) { (_) in
            completion?()
        }
    }
    
    func fadeOut(at duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            completion?()
        }
    }
}
