//
//  ListView.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

class ListView: UIViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: ListInteractor?
    var listViewModel: [ListViewModel] = []
    var cells: [Cells] {
        get {
            var builder: [Cells] = []
            
            if listViewModel.count > 0 {
                for _ in listViewModel {
                    builder.append(.listItem)
                }
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
        
        tableView.registerCell(named: Cells.getIdentifierName(type: .listItem))
        tableView.alpha = 0
    }
    
    // MARK: Network Methods
    func fetchFromInteractor() {
        loader.startAnimating()
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
            cell.setupCell(with: listViewModel[safe: index])
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
}

extension ListView: BaseViewModelProtocol {
    typealias T = ListViewModel
    
    func receiveViewModel(viewModel: [ListViewModel]) {
        loader.stopAnimating()
        
        listViewModel = viewModel
        
        tableView.reloadData()
        tableView.fadeIn(at: 0.5)
    }
}
