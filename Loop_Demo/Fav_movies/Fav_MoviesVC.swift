//
//  Fav_MoviesVC.swift
//  Loop_Demo
//
//  Created by MOKSHA on 21/11/22.
//

import UIKit

class Fav_MoviesVC: UIViewController {

    @IBOutlet weak var Backbtn: UIButton!
    @IBOutlet weak var Star_collectionview: UICollectionView!
    @IBOutlet weak var Fav_moviesCollectionview: UICollectionView!
    var Fav_Movieslist = [Moives]()
    var tempFilterlist = [Moives]()
    var MAxstar = 5
    public var bookmark_favMovielist = [Moives]()
    @IBOutlet weak var searchtxt: UITextField!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Fav_moviesCollectionview.delegate = self
        self.Fav_moviesCollectionview.dataSource = self
        self.Star_collectionview.delegate = self
        self.Star_collectionview.dataSource = self
        self.Star_collectionview.allowsMultipleSelection = false
        self.Star_collectionview.allowsSelection = true
        self.Fav_moviesCollectionview.allowsMultipleSelection = false
        self.Fav_moviesCollectionview.allowsSelection = true
        

        self.Star_collectionview.translatesAutoresizingMaskIntoConstraints = false
        self.searchtxt.delegate = self
        
        self.searchtxt.attributedPlaceholder = NSAttributedString(
            string: "Search all Favorites",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText]
        )
       


    }
    
    override func viewWillAppear(_ animated: Bool) {
  
        self.searchtxt.becomeFirstResponder()
        self.loadFav_movieslist()
        
        if var MoivesData = self.getbookmarklist() {
            self.bookmark_favMovielist = MoivesData
        }
    }
    func getbookmarklist() -> [Moives]? {
        guard let MoviesData = UserDefaults.standard.data(forKey: "SavedMoives") else { return nil }
        let MoviesArray = try! JSONDecoder().decode([Moives].self, from: MoviesData)
        return MoviesArray
    }
    
    // MARK: - Navigation
     @IBAction func Backbtn_action(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
     
    func loadFav_movieslist() {
        
       if let url = URL(string:"https://apps.agentur-loop.com/challenge/movies.json") {
            do{
                    let dataUrl = try Data(contentsOf: url)
                    let jsonDecoder = JSONDecoder()
                    let urlDataFromJson =
                        try jsonDecoder.decode([Moives].self, from: dataUrl)
                   self.Fav_Movieslist = urlDataFromJson
                  self.tempFilterlist = self.Fav_Movieslist
             
                self.Fav_moviesCollectionview.reloadData()
              } catch {
                    print(error)
                }
        }
    }
    
    @IBAction func Refresh_removefiltersAction(_ sender: Any) {
        self.searchtxt.text = ""
        self.tempFilterlist = self.Fav_Movieslist
        
        self.Fav_moviesCollectionview.reloadData()
        self.Fav_moviesCollectionview?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath,
                                                    at: .top,animated: true)
        self.Star_collectionview.reloadData()
    }
    
    func FilterMovieslistbyRate(count : Int)  {
        
        if count > 0
        {
            self.tempFilterlist = self.Fav_Movieslist.filter({
                $0.rating?.rounded(.awayFromZero) == Double(count)
            })
        }
        else
        {
            self.tempFilterlist = self.Fav_Movieslist
        }
        self.Fav_moviesCollectionview.reloadData()
    }

}

extension Fav_MoviesVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.Star_collectionview    {
            return 5
        } else {
            return  self.tempFilterlist.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Star_collectionview    {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "starCollectionViewCell", for: indexPath) as! starCollectionViewCell
            cell.UpdateStarStackview(count: self.MAxstar - indexPath.row)
           
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Fav_collectioncell", for: indexPath) as! Fav_collectioncell
            cell.Observer = self
            cell.Moviedetails = self.tempFilterlist[indexPath.row]
            if self.bookmark_favMovielist.filter({
                $0.title == self.tempFilterlist[indexPath.row].title
            }).count > 0
            {
                cell.Bookmarkimgview.isHighlighted = true
            }
            else
            {
                cell.Bookmarkimgview.isHighlighted = false
            }
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.Star_collectionview
        {
            let Cell = collectionView.cellForItem(at: indexPath) as! starCollectionViewCell
            Cell.Firststar.isHighlighted = true
            Cell.Secondstarimg.isHighlighted = true
            Cell.Thirdstarimg.isHighlighted = true
            Cell.Fourthstarimg.isHighlighted = true
            Cell.Fifthstarimg.isHighlighted = true
            
            self.FilterMovieslistbyRate(count: self.MAxstar - indexPath.row)
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.Star_collectionview
        {
            let Cell = collectionView.cellForItem(at: indexPath) as! starCollectionViewCell
            Cell.Firststar.isHighlighted = false
            Cell.Secondstarimg.isHighlighted = false
            Cell.Thirdstarimg.isHighlighted = false
            Cell.Fourthstarimg.isHighlighted = false
            Cell.Fifthstarimg.isHighlighted = false
        } else {}
    }
    
    
    
}


extension Fav_MoviesVC : UITextFieldDelegate, Fav_collectioncellDelegate
{
    
    func RemoveFromBookmarklist(Moviedetails: Moives!) {
        
        if var MoivesData = self.getbookmarklist() {
            MoivesData = MoivesData.filter({
                $0.title != Moviedetails.title
            })
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(MoivesData){
                     UserDefaults.standard.set(encoded, forKey: "SavedMoives")
            }
        }
        if var MoivesData = self.getbookmarklist() {
            self.bookmark_favMovielist = MoivesData
        }
    }
    
    
    func Addtobookmarklist(Moviedetails: Moives!) {
        
        if var MoivesData = self.getbookmarklist() {
            MoivesData.append(Moviedetails)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(MoivesData){
                     UserDefaults.standard.set(encoded, forKey: "SavedMoives")
            }
        }
        else
        {
            var MoivesData = [Moives]()
            MoivesData.append(Moviedetails)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(MoivesData){
                     UserDefaults.standard.set(encoded, forKey: "SavedMoives")
            }
        }
        if var MoivesData = self.getbookmarklist() {
            self.bookmark_favMovielist = MoivesData
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text != ""
       {
            self.tempFilterlist = self.Fav_Movieslist.filter({
                $0.title!.lowercased().hasPrefix(textField.text!.lowercased())
           })
       }
       else
       {
           self.tempFilterlist = self.Fav_Movieslist
       }
       self.Fav_moviesCollectionview.reloadData()
          
     }

    
}
