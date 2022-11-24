//
//  fav_moviecollectioncell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 04/11/22.
//

import UIKit

class fav_moviecollectioncell: UICollectionViewCell {

    @IBOutlet weak var Moiveposterimg: UIImageView!
    
    var Moviedetails : Moives?
    {
        didSet
        {
            self.FillMovieDetails()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func FillMovieDetails()  {
        
        if let imgurl = Moviedetails?.posterUrl
        {
            self.Moiveposterimg.downloaded(from: imgurl)
        }
    }

}
