//
//  Fav_collectioncell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 22/11/22.
//

import UIKit

class Fav_collectioncell: UICollectionViewCell {

    @IBOutlet weak var Bookmarkimgview: UIImageView!
    @IBOutlet weak var STarimgview: UIImageView!
    @IBOutlet weak var Movietitlelbl: UILabel!
    @IBOutlet weak var Moiveimgview: UIImageView!
    @IBOutlet weak var Yearlbl: UILabel!
    
    var Moviedetails : Moives!
    {
        didSet
        {
            self.FillMovieDetails()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        Bookmarkimgview.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
       if self.Bookmarkimgview.isHighlighted == true
        {
           Bookmarkimgview.isHighlighted = false
       } else
        {
           Bookmarkimgview.isHighlighted = true
        }
    }
    
    func SetupDarkStarImagefromRate(Rate :  Double) -> UIImage {
        
        let roundupvalue = Rate.rounded(.awayFromZero)
        switch roundupvalue {
        case 1:
            return UIImage(named: "DarkStars=1")!
        case 2:
            return UIImage(named: "DarkStars=2")!
        case 3:
            return UIImage(named: "DarkStars=3")!
        case 4:
            return UIImage(named: "DarkStars=4")!
        case 5:
            return UIImage(named: "DarkStars=5")!
        default:
            return UIImage()
        }
    }
    
    func FillMovieDetails()  {
        
        if let releaseyear = Moviedetails?.releaseDate {
            self.Yearlbl.text = releaseyear.ReturnyearfromDate()
        }
        
        if let title = Moviedetails?.title
        {
            self.Movietitlelbl.font = UIFont(name: "SFPro-Bold", size: 24)
            self.Movietitlelbl.text = title
        }
       
        if let result = UserDefaults.standard.value(forKey: "bookmark_Movielist") as? [String:[Moives]]
        {
            let dic =  result.values
        }
        
        if let imgurl = Moviedetails?.posterUrl
        {
            self.Moiveimgview.downloaded(from: imgurl)
        }
        
        if let rate = Moviedetails.rating
        {
            self.STarimgview.image = self.SetupDarkStarImagefromRate(Rate: rate)
            
        }
        
    }

}
