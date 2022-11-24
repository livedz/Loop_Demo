//
//  Bottomtbcell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 04/11/22.
//

import UIKit

protocol BottomtbCellDelegate {
    func ExpandMoviedetails(Moviedetails : Moives)
    func Addtobookmarklist(Moviedetails : Moives!)
    func RemoveFromBookmarklist(Moviedetails : Moives!)
}

class Bottomtbcell: UITableViewCell {

    
    @IBOutlet weak var Moiveposterimg: UIImageView!
    @IBOutlet weak var Yearlbl: UILabel!
    @IBOutlet weak var MovieTitlelbl: UILabel!
    @IBOutlet weak var Starimgview: UIImageView!
    @IBOutlet weak var Bookmarkimgview: UIImageView!
    @IBOutlet weak var Topview: UIView!
    var Observer : BottomtbCellDelegate?
    
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
        let Toptap = UITapGestureRecognizer(target: self, action: #selector(self.Moviedetails_topTap(_:)))
        Topview.addGestureRecognizer(Toptap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
       if self.Bookmarkimgview.isHighlighted == true
        {
           Bookmarkimgview.isHighlighted = false
           self.Observer?.RemoveFromBookmarklist(Moviedetails: self.Moviedetails)
       } else
        {
           Bookmarkimgview.isHighlighted = true
           self.Observer?.Addtobookmarklist(Moviedetails: self.Moviedetails)
        }
    }
    
    @objc func Moviedetails_topTap(_ sender: UITapGestureRecognizer? = nil) {
        self.Observer?.ExpandMoviedetails(Moviedetails: self.Moviedetails)
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
            self.MovieTitlelbl.font = UIFont(name: "SFPro-Bold", size: 24)
            self.MovieTitlelbl.text = title
        }
       
        if let result = UserDefaults.standard.value(forKey: "bookmark_Movielist") as? [String:[Moives]]
        {
            let dic =  result.values
        }
        
        if let imgurl = Moviedetails?.posterUrl
        {
            self.Moiveposterimg.downloaded(from: imgurl)
        }
        
        if let rate = Moviedetails.rating
        {
            self.Starimgview.image = self.SetupDarkStarImagefromRate(Rate: rate)
            
        }
        
    }

    
}
