//
//  DetailView.swift
//  Reign
//
//  Created by Neptali Duque on 4/7/21.
//
//  The full Clean Architecture on this module will be skipped for now
//  hope it is okay as this is just loading an URL on the WKWebView instance
//

import UIKit
import WebKit

class DetailView: UIViewController {
    
    var webView: WKWebView?
    var stringUrl: String = ""
    var url: URL?
    
    let strings = Strings.DetailView.self

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWebView()
        triggerWebLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: UI Setup
    func initializeWebView() {
        webView = WKWebView(frame: CGRect.zero)
        webView?.backgroundColor = .clear
        webView?.alpha = 0
        webView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(webView!)
        
        let constraints = [
            webView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            webView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        url = URL(string: stringUrl)
    }
    
    func triggerWebLoad() {
        let isNetworkAvailable =  ReachabilityManager.shared.isNetworkConnected()
        loadWebPage(fromCache: !isNetworkAvailable)
    }
    
    // MARK: WKWebView Utilities
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if webView?.estimatedProgress == 1 {
                view.loaderState = .loaded
                UIView.animate(withDuration: 0.5) {
                    [weak self] in
                    self?.webView?.alpha = 1
                }
            }
        }
    }
    
    internal func loadWebPage(fromCache isCacheLoad: Bool = false) {
        guard let url = url else { return }
        
        if isCacheLoad {
            Toast(duration: 3.0, text: strings.loadingFromCache, container: self.navigationController, backgroundColor: .red, direction: .top, completion: nil)
        }
        
        let request = URLRequest(url: url, cachePolicy: (isCacheLoad ? .returnCacheDataElseLoad : .reloadRevalidatingCacheData), timeoutInterval: 50)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.loaderState = .loading
            self.webView?.load(request)
            self.webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
    }
    
}
