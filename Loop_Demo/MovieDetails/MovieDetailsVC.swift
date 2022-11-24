//
//  MovieDetailsVC.swift
//  Loop_Demo
//
//  Created by MOKSHA on 18/11/22.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var Closebtn: UIButton!
    @IBOutlet weak var Bookmarkbtn: UIButton!
    @IBOutlet weak var Progressview: UIView!
    @IBOutlet weak var Descriptiontableview: UITableView!
    
    var moviedetails : Moives!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        self.Bookmarkbtn.setTitle("", for: .normal)
        self.Closebtn.setTitle("", for: .normal)
        self.Setuptableview()
    }
    
    func Setuptableview()  {
        
        self.Descriptiontableview.delegate = self
        self.Descriptiontableview.dataSource = self
        self.Descriptiontableview.register(UINib(nibName: "HeaderTbCell", bundle: nil), forCellReuseIdentifier: "HeaderTbCell")
        self.Descriptiontableview.register(UINib(nibName: "descriptionTbCell", bundle: nil), forCellReuseIdentifier: "descriptionTbCell")
        self.Descriptiontableview.register(UINib(nibName: "Staff_desctbcell", bundle: nil), forCellReuseIdentifier: "Staff_desctbcell")
        self.Descriptiontableview.register(UINib(nibName: "KeyfactTbCell", bundle: nil), forCellReuseIdentifier: "KeyfactTbCell")
        
    }
    
    @IBAction func ClosebtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func BookmarkbtnAction(_ sender: Any) {
        
    }
    
    func SetuplightStarImagefromRate(Rate :  Double) -> UIImage {
        
        let roundupvalue = Rate.rounded(.awayFromZero)
        switch roundupvalue {
        case 1:
            return UIImage(named: "LightStars=1")!
        case 2:
            return UIImage(named: "LightStars=2")!
        case 3:
            return UIImage(named: "LightStars=3")!
        case 4:
            return UIImage(named: "LightStars=4")!
        case 5:
            return UIImage(named: "LightStars=5")!
        default:
            return UIImage()
        }
    }
    
    func calculateTime(_ timeValue: Int) -> String {
            let timeMeasure = Measurement(value: Double(timeValue), unit: UnitDuration.minutes)
            let hours = timeMeasure.converted(to: .hours)
            if hours.value > 1 {
                let minutes = timeMeasure.value.truncatingRemainder(dividingBy: 60)
                return String(format: "%.f %@ %.f %@", hours.value, "h", minutes, "min")
            }
            return String(format: "%.f %@", timeMeasure.value, "min")
        }
}

extension MovieDetailsVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTbCell", for: indexPath) as? HeaderTbCell else {
                fatalError("Failed to dequeue a HeaderTbCell.")
            }
            if let imgurl = self.moviedetails.posterUrl
            {  cell.Posterimgview.downloaded(from: imgurl) }
            if self.moviedetails.rating != nil
            { cell.starimgview.image = self.SetuplightStarImagefromRate(Rate: self.moviedetails.rating!) }
            if let timestr = self.moviedetails.runtime
            { cell.timelbl.text = self.calculateTime(timestr)  }
            if let title = self.moviedetails.title
            { cell.Movienamelbl.text = title }
            if let category = self.moviedetails.genres  {
                cell.categories = category
                cell.categorycollectionview.reloadData()
            }
            if let relasedate = self.moviedetails.releaseDate
            {
                cell.releaseyearlbl.text = " (" + relasedate.ReturnyearfromDate() + ")"
                cell.Releasedatelbl.text = relasedate.manageDateformat()
            }
    
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionTbCell", for: indexPath) as? descriptionTbCell else {
                fatalError("Failed to dequeue a descriptionTbCell.")
            }
          
            if let overview = self.moviedetails.overview    {
                cell.Descriptionlbl.text = overview
            }
           return cell
        }
        else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Staff_desctbcell", for: indexPath) as? Staff_desctbcell else {
                fatalError("Failed to dequeue a Staff_desctbcell.")
            }
            if let director = self.moviedetails.director    {
                cell.isDirectorsection = true
                cell.titlelbl.text = "Director"
                cell.Directordetails = director
                cell.Collectionview.reloadData()
            }
            
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Staff_desctbcell", for: indexPath) as? Staff_desctbcell else {
                fatalError("Failed to dequeue a Staff_desctbcell.")
            }
            if let cast = self.moviedetails.cast    {
                cell.isDirectorsection = false
                cell.titlelbl.text = "Actors"
                cell.Castdetails = cast
                cell.Collectionview.reloadData()
            }
            
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeyfactTbCell", for: indexPath) as? KeyfactTbCell else {
                fatalError("Failed to dequeue a Staff_desctbcell.")
            }
            if let budget = self.moviedetails.budget    {
                cell.budgetlbl.text = budget.description
            }
            if let revenue = self.moviedetails.revenue    {
                cell.Revenuelbl.text = revenue.description
            }
            if let lang = self.moviedetails.language    {
                cell.Languagelbl.text = lang.description
            }
            if let rate = self.moviedetails.rating    {
                let rate_ = rate.rounded()
                let review = self.moviedetails.reviews!.description
                cell.Ratinglbl.text = rate_.description + "(" + review.description + ")"
            }
            
            return cell
        }
    }
    
    
}



extension UIImageView
{
   
    
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
}
