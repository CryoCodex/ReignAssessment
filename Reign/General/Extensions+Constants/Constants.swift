//
//  Constants.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

// MARK: ViewControllers used by ViewFactory.swift
struct kViewControllers {
    struct Home {
        static let list = "ListView"
        static let detail = "DetailView"
    }
}

// MARK: CollectionView and TableView related Cells
enum Cells {
    case listItem
    
    static func getIdentifierName(type: Cells) -> String {
        switch type {
        case .listItem: return "ListItemCell"
        }
    }
    
    static func getIdentifierHeight(type: Cells) -> CGFloat {
        switch type {
        case .listItem: return 0.0
        }
    }
}

// MARK: - Date Formats
struct DateFormats {
    static let serverFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let standardFormat = "MM/dd/yyyy HH:mm:ss"
}

// MARK: - General Constants and User Defaults Keys

struct Constants {
    static let appPrefix = "reign-mobile-test"
}
struct UDKeys {
    static let deletedNews = "\(Constants.appPrefix).deletedNews"
}

