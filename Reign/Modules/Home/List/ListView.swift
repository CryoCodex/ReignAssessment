//
//  ListView.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

class ListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    var refreshControl: UIRefreshControl?
    
    var strings = Strings.ListView.self
    var interactor: ListInteractor?
    var listViewModel: [ListViewModel] = []
    var cells: [Cells] {
        get {
            var builder: [Cells] = []
            
            if listViewModel.count > 0 {
                for _ in listViewModel {
                    builder.append(.listItem)
                }
            } else {
                builder.append(.listItem)
            }
            
            return builder
        }
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchFromInteractor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: UI Methods
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(triggerPullToRefresh), for: .valueChanged)
        refreshControl?.backgroundColor = .clear
        refreshControl?.tintColor = .clear
        
        tableView.refreshControl = refreshControl
        
        tableView.registerCell(named: Cells.getIdentifierName(type: .listItem))
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.alpha = 0
    }
    
    // MARK: Network Methods
    func fetchFromInteractor() {
        view.loaderState = .loading
        interactor?.fetchDataToReachability()
    }
    
    @objc func triggerPullToRefresh() {
        refreshControl?.refresherStatus = .loading
        interactor?.fetchDataToReachability()
    }
    
}

extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let type = cells[index]
        let id = Cells.getIdentifierName(type: type)
        
        switch type {
        case .listItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: id) as! ListItemCell
            
            if listViewModel.isEmpty {
                cell.setupCell(with: strings.emptyState)
            } else {
                cell.setupCell(with: listViewModel[safe: index])
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        let height = Cells.getIdentifierHeight(type: cells[index])
        if height == 0.0 { return UITableView.automaticDimension }
        return height
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: strings.tableRowDelete) { [weak self] (action, view, success) in
            guard let self = self else { return }
            
            self.interactor?.deleteNews(listViewModel: &self.listViewModel, indexPath: indexPath)
            
            if !(self.listViewModel.isEmpty) {
                tableView.deleteRows(at: [indexPath], with: .right)
            } else {
                tableView.reloadRows(at: [indexPath], with: .right)
            }

            success(true)
        }
        
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if let listViewModel = listViewModel[safe: index] {
            let vc = ViewFactory.getViewForAppView(view: .detail) as! DetailView
            vc.stringUrl = listViewModel.url
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension ListView: BaseViewModelProtocol {
    typealias T = ListViewModel
    
    func receiveViewModel(viewModel: [ListViewModel]) {
        view.loaderState = .loaded
        refreshControl?.refresherStatus = .loaded
        
        listViewModel = viewModel
        
        tableView.reloadData()
        tableView.fadeIn(at: 0.5)
    }
}
