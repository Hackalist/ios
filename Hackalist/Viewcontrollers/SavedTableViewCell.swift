//
//  SavedTableViewCell.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/18/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

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
    @IBOutlet weak var hackatonDate: UILabel!
    
    //MARK: Cell re-usage.
    override func prepareForReuse() {
        super.prepareForReuse()
        hackatonImage.image = UIImage(named: "launch")
    }
    
    
    
}
