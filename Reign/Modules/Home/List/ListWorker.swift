//
//  ListWorker.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation

class ListWorker {
    
    let networkLayer = NetworkLayer()
    
    private let queue = DispatchQueue(label: "ListWorker", qos: .userInitiated)
    
    func getNetworkNewsList(resultToInteractor: @escaping(_ result: Result<NewsHolder, NSError>) -> Void) {
        let path = API.Home.getPath(for: .list)
        queue.async { [weak self] in
            self?.networkLayer.fetchData(baseClass: NewsHolder.self, path: path, method: .get, parameters: ["query": "mobile"]) { (result) in
                
                DispatchQueue.main.async {
                    resultToInteractor(result)
                }
            }
        }
    }
    
    func getCoreDataNewsList(resultToInteractor: @escaping(_ news: [News]) -> Void) {
        let news = CoreDataManager.shared.getNews()
        resultToInteractor(news)
    }
}
