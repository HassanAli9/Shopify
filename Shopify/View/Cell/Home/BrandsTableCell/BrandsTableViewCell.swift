//
//  BrandsTableViewCell.swift
//  Shopify
//
//  Created by Nasr on 14/03/2022.
//

import UIKit
import Kingfisher

protocol brandNameProtocol{
    func transBrandName (brandName: String) -> Void
}

class BrandsTableViewCell: UITableViewCell {

    @IBOutlet weak var brandCollectionView: UICollectionView!
    static let identifier = "BrandsTableViewCell"
    static func Nib()-> UINib{
        return UINib(nibName: "BrandsTableViewCell", bundle: nil)
    }
    let homeViewModel = HomeViewModel()
    var arrayOfBrands: [Smart_collections] = []
    var brandDelegate: brandNameProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
        setBrands()
    }
    
    func setupCollectionView(){
        brandCollectionView.register(BrandsCollectionViewCell.Nib(), forCellWithReuseIdentifier: BrandsCollectionViewCell.identifier)
        brandCollectionView.delegate = self
        brandCollectionView.dataSource = self
    }
    
    func setBrands(){
        homeViewModel.bindSuccessToView = {
            self.arrayOfBrands = self.homeViewModel.brands
            self.brandCollectionView.reloadData()
        }
        
        homeViewModel.bindFailedToView = {
            print("error when set brands")
        }
    }
}

extension BrandsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfBrands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandsCollectionViewCell.identifier, for: indexPath) as! BrandsCollectionViewCell
        
        if let brandImageStr = self.arrayOfBrands[indexPath.row].image?.src,  let brandUrl = URL(string: brandImageStr){
            
            cell.brandImageView.kf.indicatorType = .activity
            cell.brandImageView.kf.setImage(with: brandUrl)
            cell.brandLabel.text = self.arrayOfBrands[indexPath.row].title
            
            /*cell.viewBrandImage.layer.borderColor = UIColor.gray.cgColor
            cell.viewBrandImage.layer.borderWidth = 0.5
            cell.viewBrandImage.layer.cornerRadius = 25*/
            
            cell.brandImageView.layer.borderColor = UIColor.gray.cgColor
            cell.brandImageView.layer.borderWidth = 0.5
            cell.brandImageView.layer.cornerRadius = 25
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 0.43, height: self.frame.width * 0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let brandName = arrayOfBrands[indexPath.row].title else {return}
        self.brandDelegate?.transBrandName(brandName: brandName)
    }
}
