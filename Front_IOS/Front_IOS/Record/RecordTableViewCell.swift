//
//  RecordTableViewCell.swift
//  Front_IOS
//
//  Created by 박다미 on 2023/05/27.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
