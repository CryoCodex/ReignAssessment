//
//  LottieExtensions.swift
//  Reign
//
//  Created by Neptali Duque on 4/7/21.
//

import UIKit
import Lottie

public extension UIView {
    
    enum LoaderState {
        case loading
        case loaded
    }
    
    var loaderState: LoaderState {
        set {
            switch newValue {
            case .loading:
                isUserInteractionEnabled = false
                if let animationView = viewWithTag(77) as? AnimationView {
                    bringSubviewToFront(animationView)
                    animationView.play()
                    animationView.isHidden = false
                    return
                }
                let animationView = AnimationView()
                let animation = Animation.named("Loader")
                animationView.backgroundBehavior = .pauseAndRestore
                animationView.animation = animation
                animationView.tag = 77
                let animationHeight: CGFloat = 65
                let animationWidth: CGFloat = 65
            
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2-(animationWidth/2), y: UIScreen.main.bounds.height/2 - animationHeight/2, width: animationWidth, height: animationHeight)
                animationView.loopMode = .loop
                addSubview(animationView)
                
                animationView.play()
                break
                
            case .loaded:
                isUserInteractionEnabled = true
                if let animationView = viewWithTag(77) as? AnimationView {
                    animationView.stop()
                    animationView.isHidden = true
                }
            }
        }
        get {
            return .loaded
        }
    }
}
