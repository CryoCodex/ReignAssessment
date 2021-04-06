//
//  Protocols.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

// Basic protocol for time saving I'll just ignore any fetch data errors/messages for now
protocol BaseNetworkProtocol: class {
    associatedtype T
    func didGetData(data: [T])
    func didNotGetData()
}

protocol BaseViewModelProtocol: class {
    associatedtype T
    func receiveViewModel(viewModel: [T])
}
