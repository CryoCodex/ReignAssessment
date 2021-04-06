//
//  ListInteractor.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation

class ListInteractor {
    
    var presenter: ListPresenter
    var worker: ListWorker
    
    init(presenter: ListPresenter, worker: ListWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchDataToReachability() {
        let isNetworkAvailable = ReachabilityManager.shared.isNetworkConnected()
        
        if isNetworkAvailable {
            worker.getNetworkNewsList { [weak self] (result) in
                if let newsHolder = try? result.get() {
                    self?.presenter.didGetData(data: newsHolder.hits ?? [])
                } else {
                    self?.presenter.didNotGetData()
                }
            }
        } else {
            worker.getCoreDataNewsList { [weak self] (news) in
                self?.presenter.didGetData(data: news)
            }
        }
    }
    
}
