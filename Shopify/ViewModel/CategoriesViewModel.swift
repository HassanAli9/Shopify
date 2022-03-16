//
//  CategoriesViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 15/03/2022.
//

import Foundation

class CategoriesViewModel : NSObject {
    
    var networkService = Networking()
//    var bindingCategoriesViewModelToView : (()->()) = {}
//    var bindingErrorToView : (()->()) = {}
    
//    var allProducts:[Product]!{
//        didSet {
//            self.bindingCategoriesViewModelToView()
//        }
//    }

//    var errorMessage:String!{
//        didSet{
//            self.bindingErrorToView()
//        }
//    }
    
    

    override init() {
        super.init()
        self.networkService = Networking()
//        self.fetchProductsfromAPI()

    }
    
//    func fetchProductsfromAPI(){
//        networkService.getAllProductsInCategory(complition: { products, error in
//            if let productsList = products {
//                self.allProducts=productsList.products!
//            }else{
//                let messege = error?.localizedDescription
//                self.errorMessage=messege
//            }
//        }, collectionID: 272069034031)
//
//    }
    
    func getProductsfromAPI(collectioID:Int,complition:@escaping (Products?,Error?)->Void){
        networkService.getAllProductsInCategory(complition: complition, collectionID: collectioID)
        
    }
    
//    func filterDataByProductType(categoryName:String)->[Product]{
//
//    }
    
  
        
}
