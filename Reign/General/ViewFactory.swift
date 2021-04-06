//
//  ViewFactory.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

class ViewFactory {
    enum AppView {
        case list
    }
    
    class func getViewForAppView(view: AppView) -> UIViewController {
        switch view {
        case .list:
            let controller = ListView(nibName: kViewControllers.Home.list, bundle: nil)
            let worker = ListWorker()
            let presenter = ListPresenter(view: controller)
            let interactor = ListInteractor(presenter: presenter, worker: worker)
            controller.interactor = interactor
            
            let navigationController = UINavigationController(rootViewController: controller)
            return navigationController
        }
    }
}
