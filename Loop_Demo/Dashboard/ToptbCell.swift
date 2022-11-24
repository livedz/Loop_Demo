//
//  ToptbCell.swift
//  Loop_Demo
//
//  Created by MOKSHA on 04/11/22.
//

import UIKit


protocol TopviewDelegate {
    func Expend_favmovielist()
}

class ToptbCell: UITableViewCell, seeallbtnDelegate {
  

    @IBOutlet weak var Searchbtn: UIButton!
    @IBOutlet weak var Fav_movieCollectionview: UICollectionView!
//    var flowLayout = UICollectionViewFlowLayout()
   
    var Fav_Movieslist = [Moives]()
    var observer : TopviewDelegate?
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Searchbtn.setTitle("", for: .normal)
        self.Fav_movieCollectionview.delegate = self
        self.Fav_movieCollectionview.dataSource = self
        
        self.loadFav_movieslist()
        
//        self.flowLayout.scrollDirection = .horizontal
//        self.flowLayout.sectionFootersPinToVisibleBounds = true
//
//        self.Fav_movieCollectionview.collectionViewLayout =  flowLayout
//
        self.Fav_movieCollectionview.register(UINib(nibName: "fav_moviecollectioncell", bundle: nil)
                                            , forCellWithReuseIdentifier: "fav_moviecollectioncell")
       
        self.Fav_movieCollectionview.register(UINib(nibName: "Footerbtnview", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footerbtnview")

    }
    private func createFlexibleFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
            let width = view.bounds.width
            let padding: CGFloat = 12
            let minimumItemSpacing: CGFloat = 10
            let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)

            let itemWidth = traitCollection.horizontalSizeClass == .compact ? availableWidth / 2 : availableWidth / 3

            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

            flowLayout.sectionFootersPinToVisibleBounds = true

            return flowLayout
        }
    func loadFav_movieslist() {
        
       if let url = URL(string:"https://apps.agentur-loop.com/challenge/movies.json") {
            do{
                    let dataUrl = try Data(contentsOf: url)
                    let jsonDecoder = JSONDecoder()
                    let urlDataFromJson =
                        try jsonDecoder.decode([Moives].self, from: dataUrl)
                   self.Fav_Movieslist = urlDataFromJson
              } catch {
                    print(error)
                }
        }
    }
    
    @IBAction func Searchbtn_action(_ sender: Any) {
        self.observer?.Expend_favmovielist()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ToptbCell : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 3
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fav_moviecollectioncell", for: indexPath) as! fav_moviecollectioncell
            cell.Moviedetails = self.Fav_Movieslist[indexPath.row]
            return cell
        
    }
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
          return CGSize(width: 182.0, height: 270.0)
         
      }
    

    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footerbtnview", for: indexPath)
            as! Footerbtnview
            footerView.obsever = self
            return footerView

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: 165.0, height: 270.0)
    }


    func ExpendCollectionview() {
        self.observer?.Expend_favmovielist()
    }
    
}

