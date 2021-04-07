//
//  ListInteractor.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

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
                    let dataArray = newsHolder.hits ?? []
                    var compacted = dataArray.filter({
                            ($0.story_title != nil || $0.title != nil) &&
                            ($0.story_url != nil || $0.url != nil)
                    })
                    
                    self?.filterFromDeletedIds(compacted: &compacted)
                    
                    CATransaction.begin()
                    CoreDataManager.shared.saveNews(newsArray: compacted)
                    CATransaction.commit()
                    
                    CATransaction.setCompletionBlock { [weak self] in
                        self?.worker.getCoreDataNewsList { [weak self] (news) in
                            self?.presenter.didGetData(data: news)
                        }
                    }
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
    
    func filterFromDeletedIds(compacted: inout [News]) {
        if let deletedNews = UserDefaults.standard.string(forKey: UDKeys.deletedNews) {
            let ids = deletedNews.split(separator: ",").map(String.init)
            for id in ids {
                if let index = compacted.firstIndex(where: {$0.object_id == id}) {
                    compacted.remove(at: index)
                }
            }
        }
    }
    
    func deleteNews(listViewModel: inout [ListViewModel], indexPath: IndexPath) {
        let removed = listViewModel.remove(at: indexPath.row)
        CoreDataManager.shared.deleteNews(listViewModel: removed)
        
        if var deletedNews = UserDefaults.standard.string(forKey: UDKeys.deletedNews) {
            deletedNews += ",\(removed.id)"
            UserDefaults.standard.setValue(deletedNews, forKey: UDKeys.deletedNews)
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.setValue(removed.id, forKey: UDKeys.deletedNews)
            UserDefaults.standard.synchronize()
        }
    }
    
}
