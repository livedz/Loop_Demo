//
//  Footerbtnview.swift
//  Loop_Demo
//
//  Created by MOKSHA on 21/11/22.
//

import UIKit

protocol seeallbtnDelegate {
    func ExpendCollectionview()
}
class Footerbtnview: UICollectionReusableView {

    var obsever : seeallbtnDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.backgroundColor = UIColor.purple
        
        self

    }
    
    

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

    }
    
    @IBAction func SeeallbtnAction(_ sender: Any) {
        
        self.obsever?.ExpendCollectionview()
    }
    
}
