//
//  SearchTableViewCell.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/18/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    @IBOutlet weak var hackatonImage: UIImageView!
    @IBOutlet weak var hackatonTitle: UILabel!
    @IBOutlet weak var hackatonDateLabel: UILabel!
    @IBOutlet weak var hackatonCityLabel: UILabel!
    @IBOutlet weak var hackatonNotesLabel: UILabel!
    
    
    
    //MARK: Cell re-usage.
    override func prepareForReuse() {
        super.prepareForReuse()
        hackatonImage.image = UIImage(named: "launch")
    }

    
    
    
    
    
}
