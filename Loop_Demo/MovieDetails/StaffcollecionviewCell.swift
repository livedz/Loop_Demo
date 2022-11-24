//
//  StaffcollecionviewCell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 18/11/22.
//

import UIKit

class StaffcollecionviewCell: UICollectionViewCell {

    @IBOutlet weak var userimageview: UIImageView!
    
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    
    var castdetails : Cast? {
        didSet {
            self.Setupcastdetails()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func Setupcastdetails()  {
        if let imgurl = self.castdetails?.pictureUrl {
            self.userimageview.downloaded(from: imgurl)
        }
        if let name = self.castdetails?.name {
            self.namelbl.text = name
        }
        if let character = self.castdetails?.character {
            self.descriptionlbl.text = character
        }
    }
}
