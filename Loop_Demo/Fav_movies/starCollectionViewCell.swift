//
//  starCollectionViewCell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 22/11/22.
//

import UIKit

class starCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var Firststarwidth: NSLayoutConstraint!
    @IBOutlet weak var Secondstarwidth: NSLayoutConstraint!
    @IBOutlet weak var Thirdstarwidth: NSLayoutConstraint!
    @IBOutlet weak var Fourthdstarwidth: NSLayoutConstraint!
    @IBOutlet weak var Fifthstarwidth: NSLayoutConstraint!
    
    @IBOutlet weak var Firststar: UIImageView!
    @IBOutlet weak var Fifthstarimg: UIImageView!
    @IBOutlet weak var Secondstarimg: UIImageView!
    @IBOutlet weak var Fourthstarimg: UIImageView!
    @IBOutlet weak var Thirdstarimg: UIImageView!
    
    
    
    func  UpdateStarStackview(count : Int)  {
        
     
        switch count {
        case 5:
            self.Firststarwidth.constant = 14.0
            self.Secondstarwidth.constant = 14.0
            self.Thirdstarwidth.constant = 14.0
            self.Fourthdstarwidth.constant = 14.0
            self.Fifthstarwidth.constant = 14.0
            return
        case 4:
            self.Firststarwidth.constant = 14.0
            self.Secondstarwidth.constant = 14.0
            self.Thirdstarwidth.constant = 0
            self.Fourthdstarwidth.constant = 14.0
            self.Fifthstarwidth.constant = 14.0
            return
        case 3:
            self.Firststarwidth.constant = 0
            self.Secondstarwidth.constant =  14.0
            self.Thirdstarwidth.constant = 14.0
            self.Fourthdstarwidth.constant =  14.0
            self.Fifthstarwidth.constant = 0
            return
        case 2:
            self.Firststarwidth.constant = 0
            self.Secondstarwidth.constant = 14.0
            self.Thirdstarwidth.constant = 0
            self.Fourthdstarwidth.constant = 14.0
            self.Fifthstarwidth.constant = 0
            return
        default:
            self.Firststarwidth.constant = 0
            self.Secondstarwidth.constant = 0
            self.Thirdstarwidth.constant = 14.0
            self.Fourthdstarwidth.constant = 0
            self.Fifthstarwidth.constant = 0
            return
        }
    }
    
    
    
}


