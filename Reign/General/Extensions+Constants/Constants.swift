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
