//
//  ViewController.swift
//  Loop_Demo
//
//  Created by MOKSHA on 31/10/22.
//

import UIKit





class HomeVC: UIViewController, TopviewDelegate {
   

  
    @IBOutlet weak var Hometableview: UITableView!
    @IBOutlet weak var Progessview: UIView!
    var Fav_Movieslist = [Moives]()
    var Staffpicks_Movieslist = [Moives]()
    public var bookmark_favMovielist = [Moives]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
      
        
        self.loadStaffpicks_movieslist()
        if Staffpicks_Movieslist.count > 0
        {
            self.Progessview.isHidden = true
            self.Setuptableviews()
        }
    }

    func Setuptableviews()  {
        self.Hometableview.delegate = self
        self.Hometableview.dataSource = self
        self.Hometableview.register(UINib(nibName: "ToptbCell", bundle: nil), forCellReuseIdentifier: "ToptbCell")
        self.Hometableview.register(UINib(nibName: "Bottomtbcell", bundle: nil), forCellReuseIdentifier: "Bottomtbcell")
        
      
    }
    
      func loadStaffpicks_movieslist() {
         if let url = URL(string:"https://apps.agentur-loop.com/challenge/staff_picks.json") {
              do{
                      let dataUrl = try Data(contentsOf: url)
                      let jsonDecoder = JSONDecoder()
                      let urlDataFromJson =
                          try jsonDecoder.decode([Moives].self, from: dataUrl)
                     self.Staffpicks_Movieslist = urlDataFromJson
              } catch {
                  print(error)
             }
          }
      }
  
    func Expend_favmovielist() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "Fav_MoviesVC") as! Fav_MoviesVC

        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
}

extension  HomeVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        } else{
            return self.Staffpicks_Movieslist.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToptbCell", for: indexPath) as! ToptbCell
            cell.observer = self
            cell.loadFav_movieslist()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Bottomtbcell", for: indexPath) as! Bottomtbcell
            cell.Observer = self
            cell.Moviedetails = self.Staffpicks_Movieslist[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1
        {

            let title = "OUR STAFF PICKS"
            return title
        }
        else
        {
            return nil
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 453 } else { return 140}
    }
    
    
}

extension HomeVC : BottomtbCellDelegate {
    
    func ExpandMoviedetails(Moviedetails: Moives) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        VC.modalPresentationStyle = .overFullScreen
        VC.moviedetails = Moviedetails
        self.navigationController?.present(VC, animated: true)
     
    }
    
    
    
}

extension UIView
{
    @IBInspectable var cornerRadius: CGFloat {
         get {
           return Double(self.layer.cornerRadius)
         }set {
           self.layer.cornerRadius = CGFloat(newValue)
         }
    }
    @IBInspectable var borderWidth: Double {
          get {
            return Double(self.layer.borderWidth)
          }
          set {
           self.layer.borderWidth = CGFloat(newValue)
          }
    }
    @IBInspectable var borderColor: UIColor? {
         get {
            return UIColor(cgColor: self.layer.borderColor!)
         }
         set {
            self.layer.borderColor = newValue?.cgColor
         }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
           return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
           self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
           return self.layer.shadowOpacity
        }
        set {
           self.layer.shadowOpacity = newValue
       }
    }
}

extension String
{
    func manageDateformat() -> String
    {

        let dateFormats = ["yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd", "MM-dd-yyyy","MMM dd,yyyy","dd,MMMM yyyy","yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", "dd/MM/yyyy","yyyy-MM-dd'T'HH:mm:ss.SSSZ","yyyy/MM/dd"]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        for dateFormat in dateFormats {
                formatter.dateFormat = dateFormat
                if let date = formatter.date(from: self) {
                    let stringformat = DateFormatter()
                    stringformat.dateFormat =  "dd.MM.YYYY"
                    return stringformat.string(from: date)
                    
                }
         }
        return self
    }
    
    
    func ReturnyearfromDate() -> String
    {

        let dateFormats = ["yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd", "MM-dd-yyyy","MMM dd,yyyy","dd,MMMM yyyy","yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", "dd/MM/yyyy","yyyy-MM-dd'T'HH:mm:ss.SSSZ","yyyy/MM/dd"]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        for dateFormat in dateFormats {
                formatter.dateFormat = dateFormat
                if let date = formatter.date(from: self) {
                    let stringformat = DateFormatter()
                    stringformat.dateFormat =  "yyyy"
                    return stringformat.string(from: date)
                    
                }
         }
        return self
    }
}


extension UIImageView
{
    func SetupStarimages(starcount: Int) -> UIImage {
        
        switch starcount {
        case 1:
            return UIImage(named: "Stars=1")!
    
        case 2:
            return UIImage(named: "Stars=2")!
          
        case 3:
            return UIImage(named: "Stars=3")!
         
        case 4:
            return UIImage(named: "Stars=4")!
          
        case 5:
            return UIImage(named: "Stars=5")!
           
        default:
            return UIImage(named: "Stars=5")!
        
        }
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
        func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    
}
