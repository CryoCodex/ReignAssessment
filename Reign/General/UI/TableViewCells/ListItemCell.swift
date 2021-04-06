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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI() {
        newsTitleLabel.font = UIFont.systemFont(ofSize: 18)
        newsMetadataLabel.font = UIFont.systemFont(ofSize: 10)
        
        newsTitleLabel.textColor = UIColor.black
        newsMetadataLabel.textColor = UIColor.lightGray
    }
    
    func setupCell(with model: ListViewModel) {
        newsTitleLabel.text = model.title
        newsMetadataLabel.text = model.metadata
    }
}
