//
//  BaseNavigationController.swift
//  Reign
//
//  Created by Neptali Duque on 4/7/21.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    var strings = Strings.Reachability.self
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilityManager.shared.delegate = self
    }
}

extension BaseNavigationController: ReachabilityDelegate {
    func networkReachable() {
        Toast(duration: 5.0, text: strings.networkAvailable, container: self, backgroundColor: .green, direction: .bottom, completion: nil)
    }
    
    func networkIsNotReachable() {
        Toast(duration: 5.0, text: strings.networkUnavailable, container: self, backgroundColor: .red, direction: .bottom, completion: nil)
    }
}

