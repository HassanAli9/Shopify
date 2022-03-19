//
//  OrderTableViewCell.swift
//  myorders
//
//  Created by Omar Ahmed on 18/03/2022.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell,UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myorderitemCell", for: indexPath) as! MyOrderItemCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/1.2, height: 170)
    }
    
    
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        orderCollectionView.dataSource=self
        orderCollectionView.delegate=self
        orderCollectionView.register(UINib(nibName: "MyOrderItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myorderitemCell")
       
    }

    
}
