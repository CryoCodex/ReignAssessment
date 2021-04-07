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
        let viewModel = prepareData(dataArray: data)
        view?.receiveViewModel(viewModel: viewModel)
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
            let objectId = data.object_id ?? ""
            let url = getRealUrl(for: data)
            
            let viewModelItem = ListViewModel(title: title, metadata: metadata, id: objectId, url: url)
            listViewModel.append(viewModelItem)
        }
        
        return listViewModel
    }
    
    private func getRealTitle(for news: News) -> String {
        if let title = news.title { return title }
        if let storyTitle = news.story_title { return storyTitle }
        return ""
    }
    
    private func getRealUrl(for news: News) -> String {
        if let url = news.url { return url }
        if let storyUrl = news.story_url { return storyUrl }
        return ""
    }
    
    private func getMetadata(for news: News) -> String {
        return "\(news.author ?? "") - \(getDate(for: news))"
    }
    
    private func getDate(for news: News) -> String {
        
        // TimeZone shifts between formatters to make sure we are on the user's time zone
        
        let serverFormat = DateFormatter()
        serverFormat.dateFormat = DateFormats.serverFormat
        serverFormat.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateFormats.standardFormat
        
        if let date = serverFormat.date(from: news.created_at ?? "") {
            let stringDate = dateFormatter.string(from: date)
            let actualTimeZoneDate = dateFormatter.date(from: stringDate)!
            return getPastTime(for: actualTimeZoneDate)
        }
        
        return ""
    }
    
    private func getPastTime(for date : Date) -> String {
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormats.standardFormat
            let strDate: String = formatter.string(from: date)
            return strDate
        }
    }

}
