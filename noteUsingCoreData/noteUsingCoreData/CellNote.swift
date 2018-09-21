//
//  CellNote.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/13/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import UIKit

class CellNote: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
