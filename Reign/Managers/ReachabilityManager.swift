//
//  ReachabilityManager.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Network
import UIKit

protocol ReachabilityDelegate: class {
    func networkReachable()
    func networkIsNotReachable()
}

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    var delegate: ReachabilityDelegate?
    
    var reachability: Reachability?
    
    override init() {
        super.init()
        
        reachability = try? Reachability()
        
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(networkStatusChanged(_:)),
                    name: .reachabilityChanged,
                    object: reachability
                )
        
        reachability?.whenReachable = { [weak self] _ in
            self?.delegate?.networkReachable()
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.delegate?.networkIsNotReachable()
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func isNetworkConnected() -> Bool {
        return reachability?.connection != .unavailable
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            print("Reachable")
        case .unavailable:
            print("Network not reachable")
        }
    }
    
}
