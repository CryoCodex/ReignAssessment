//
//  ListItemCell.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

class ListItemCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsMetadataLabel: UILabel!
    
    var model: ListViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupUI()
    }
    
    override func prepareForReuse() {
        newsTitleLabel.textAlignment = .left
        newsMetadataLabel.isHidden = false
    }
    
    private func setupUI() {
        newsTitleLabel.font = UIFont.systemFont(ofSize: 18)
        newsMetadataLabel.font = UIFont.systemFont(ofSize: 10)
        
        newsTitleLabel.textColor = UIColor.black
        newsMetadataLabel.textColor = UIColor.lightGray
    }
    
    // For Items In List
    func setupCell(with model: ListViewModel?) {
        guard let model = model else { return }
        newsTitleLabel.text = model.title
        newsMetadataLabel.text = model.metadata
        self.model = model
    }
    
    // For Empty Mode List
    func setupCell(with message: String) {
        newsTitleLabel.text = message
        newsTitleLabel.textAlignment = .center
        newsMetadataLabel.isHidden = true
    }
}
