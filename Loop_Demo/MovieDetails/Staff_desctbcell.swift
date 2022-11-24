//
//  Staff_desctbcell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 01/11/22.
//

import UIKit

class Staff_desctbcell: UITableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var Collectionview: UICollectionView!
    
    
    var isDirectorsection = true
    
    var Directordetails : Director?
    var Castdetails : [Cast] = []
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.Collectionview.delegate = self
        self.Collectionview.dataSource = self
        self.SetupCollectiondetails()
    }

    func SetupCollectiondetails()  {
        self.Collectionview.delegate = self
        self.Collectionview.dataSource = self
        self.Collectionview.register(UINib(nibName: "StaffcollecionviewCell", bundle: nil), forCellWithReuseIdentifier: "StaffcollecionviewCell")
        self.Collectionview.register(UINib(nibName: "DirectorcollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DirectorcollectionViewCell")
  
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Staff_desctbcell : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isDirectorsection {
            return 1
        } else {
            return self.Castdetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDirectorsection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DirectorcollectionViewCell", for: indexPath) as? DirectorcollectionViewCell else {
                fatalError("Failed to dequeue a DirectorcollectionViewCell.")
            }
            cell.namelbl.text = self.Directordetails?.name
            if let imgurl = self.Directordetails?.pictureUrl {
                cell.Directorimgview.downloaded(from: imgurl) }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StaffcollecionviewCell", for: indexPath) as? StaffcollecionviewCell else {
                fatalError("Failed to dequeue a StaffcollecionviewCell.")
            }
            cell.namelbl.text = self.Castdetails[indexPath.row].name
            cell.descriptionlbl.text = self.Castdetails[indexPath.row].character
            if let imgurl = self.Castdetails[indexPath.row].pictureUrl {
                cell.userimageview.downloaded(from: imgurl) }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4 , height: 130 )
        }
}
