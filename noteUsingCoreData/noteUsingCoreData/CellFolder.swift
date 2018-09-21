//
//  TableViewCell.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/12/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import UIKit

class CellFolder: UITableViewCell {
    @IBOutlet weak var lbNameFolder: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
