//
//  ReachabilityManager.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Network

protocol ReachabilityDelegate: class {
    func networkReachable()
    func networkIsNotReachable()
}

class ReachabilityManager {
    
    static let shared = ReachabilityManager()
    
    let monitor: NWPathMonitor?
    var delegate: ReachabilityDelegate?
    
    init() {
        monitor = NWPathMonitor()
        
        let queue = DispatchQueue(label: "ReachabilityManager", qos: .background)
        monitor?.start(queue: queue)
        
        networkUpdatesListener()
    }

    func networkUpdatesListener() {
        monitor?.pathUpdateHandler = { [weak self] updatedPath in
            if updatedPath.status == .satisfied {
                self?.delegate?.networkReachable()
            } else {
                self?.delegate?.networkIsNotReachable()
            }
        }
    }
    
    func isNetworkConnected() -> Bool {
        return monitor?.currentPath.status == .satisfied
    }
}
