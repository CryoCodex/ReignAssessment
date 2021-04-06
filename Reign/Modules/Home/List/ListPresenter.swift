//
//  ListPresenter.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation

protocol ListPresenterDelegate: class {
    func receiveViewModel(viewModel: [ListViewModel])
}

class ListPresenter: BaseNetworkProtocol {
    typealias T = News
    
    weak var view: ListView?
    
    init(view: ListView) {
        self.view = view
    }
    
    func didGetData(data: [News]) {
        
    }
    
    func didNotGetData() {
        print("Whoops something went wrong getting the data.")
    }
}

// MARK: - Data Preparation
extension ListPresenter {
    private func prepareData(dataArray: [News]) -> [ListViewModel] {
        var listViewModel: [ListViewModel] = []
        
        for data in dataArray {
            let title = getRealTitle(for: data)
            let metadata = getMetadata(for: data)
        }
        
        return listViewModel
    }
    
    private func getRealTitle(for news: News) -> String {
        if let title = news.title { return title }
        if let storyTitle = news.story_title { return storyTitle }
        return ""
    }
    
    private func getMetadata(for news: News) -> String {
        return ""
    }
 
}
