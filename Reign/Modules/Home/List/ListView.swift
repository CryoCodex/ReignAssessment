//
//  ListView.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

class ListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: [ListViewModel] = []
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: UI
    func setupTableView() {
        
    }
}
