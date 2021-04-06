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
    
    
}
