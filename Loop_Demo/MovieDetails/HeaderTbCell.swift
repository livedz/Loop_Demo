//
//  HeaderTbCell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 01/11/22.
//

import UIKit

class HeaderTbCell: UITableViewCell {

    @IBOutlet weak var Posterimgview: UIImageView!
    
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var Movienamelbl: UILabel!
    @IBOutlet weak var starimgview: UIImageView!
    @IBOutlet weak var Releasedatelbl: UILabel!
    
    @IBOutlet weak var releaseyearlbl: UILabel!
    @IBOutlet weak var categorycollectionview: UICollectionView!
    
    
    var categories : [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.categorycollectionview.delegate = self
        self.categorycollectionview.dataSource = self
        
        if let collectionViewLayout = categorycollectionview.collectionViewLayout as? UICollectionViewFlowLayout {
                    collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                    collectionViewLayout.minimumLineSpacing = 12
                    collectionViewLayout.minimumInteritemSpacing = 12
          
        }
        
        self.categorycollectionview.register(UINib(nibName: "categorycollectionviewcell", bundle: nil), forCellWithReuseIdentifier: "categorycollectionviewcell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HeaderTbCell : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycollectionviewcell", for: indexPath) as! categorycollectionviewcell
        cell.categorylbl.text = categories[indexPath.row]
        return cell
    }
    
     
}
