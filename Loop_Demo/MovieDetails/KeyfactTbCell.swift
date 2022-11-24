//
//  KeyfactTbCell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 01/11/22.
//

import UIKit

class KeyfactTbCell: UITableViewCell {

    @IBOutlet weak var budgetlbl: UILabel!
    @IBOutlet weak var Ratinglbl: UILabel!
    @IBOutlet weak var Revenuelbl: UILabel!
    @IBOutlet weak var Languagelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
