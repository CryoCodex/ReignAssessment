//
//  Strings.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation

struct Strings {
    struct ListView {
        static let tableRowDelete = NSLocalizedString("list_view.action.delete", comment: "")
        static let emptyState = NSLocalizedString("list_view.empty_state", comment: "")
    }
    
    struct DetailView {
        static let loadingFromCache = NSLocalizedString("detail_view.loading_from_cache", comment: "")
    }
    
    struct Reachability {
        static let networkUnavailable = NSLocalizedString("reachability.network_unavailable", comment: "")
        static let networkAvailable = NSLocalizedString("reachability.network_available", comment: "")
    }
}
