//
//  ShowsViewController.swift
//  TMS
//
//  Created by Y50 on 26/09/16.
//  Copyright © 2016 Chashmeet Singh. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class ShowsViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var shows: Results<Show>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        getSavedShows()
    }
    
    func getSavedShows() {
        let realm = try! Realm()
        shows = realm.objects(Show.self)
    }
    
}

extension ShowsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ShowTabCell
        let item = shows[(indexPath as NSIndexPath).row]
        
        cell.showTitle.text = item.title
        cell.showTitle.isHidden = false
        
        cell.bannerImageView.kf.setImage(with: URL(string: item.banner!)!,
                                         placeholder: nil,
                                         options: nil,
            progressBlock: { (receivedSize, totalSize) -> () in
                //print("Download Progress: \(receivedSize)/\(totalSize)")
            },
            completionHandler: { (image, error, cacheType, imageURL) -> () in
                //self.imageIndicator.stopAnimating()
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    cell.bannerImageView.isHidden = false
                    cell.showTitle.isHidden = true
                }
            }
        )
        
        return cell
    }
    
}

extension ShowsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0
    }
    
}