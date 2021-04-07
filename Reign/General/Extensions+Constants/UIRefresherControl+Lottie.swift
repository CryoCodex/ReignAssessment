//
//  UIRefresherControl+Lottie.swift
//  Reign
//
//  Created by Neptali Duque on 4/7/21.
//

import UIKit
import Lottie

public extension UIRefreshControl {
    
    enum RefresherStatus {
        case loading
        case loaded
    }
    
    var refresherStatus: RefresherStatus {
        set{
            switch newValue {
            case .loading:
                isUserInteractionEnabled = false
                tintColor = .clear
                backgroundColor = .clear
                if let animationView = viewWithTag(88) as? AnimationView {
                    bringSubviewToFront(animationView)
                    animationView.play()
                    animationView.isHidden = false
                    return
                }
                let animationView = AnimationView()
                let animation = Animation.named("Loader")
                animationView.animation = animation
                animationView.tag = 88
                let animationHeight: CGFloat = 56
                let animationWidth: CGFloat = 56
                animationView.frame = CGRect(x: (bounds.width / 2) - (animationWidth / 2), y: 0, width: animationWidth, height: animationHeight)
                animationView.loopMode = .loop
                addSubview(animationView)
                animationView.play()
                beginRefreshing()
                break
            case .loaded:
                isUserInteractionEnabled = true
                if let animationView = viewWithTag(88) as? AnimationView {
                    animationView.stop()
                    animationView.isHidden = true
                    beginRefreshing()
                    endRefreshing()
                }
            }
        }
        
        get {
            return .loaded
        }
    }
}
