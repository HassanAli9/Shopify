//
//  CategoriesViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 15/03/2022.
//

import Foundation

class CategoriesViewModel : NSObject {
    
    var networkService = Networking()
    var coreDataServices = CoreDataServices()

    
    
    override init() {
        super.init()
        self.networkService = Networking()
    }
    
    func getProductsfromAPI(collectioID:Int,complition:@escaping (Products?,Error?)->Void){
        networkService.getAllProductsInCategory(complition: complition, collectionID: collectioID)
        
    }
}

extension CategoriesViewModel{
    func saveProductToWishList(){
        coreDataServices.saveToCoreData { saveSuccess in
            if saveSuccess{
                print("success to save product in wishlist")
            }else{
                print("failed to save product in wishlist")
            }
        }
    }
    
    func deletedSelectedProduct(productID: Int){
        coreDataServices.getAllWishListProduct { productList, error in
            guard let productList = productList, let customerID = Helper.shared.getUserID()  else { return }
            
            for selectedProduct in productList{
                if selectedProduct.customerID == customerID && selectedProduct.productID == productID {
                    self.coreDataServices.deletedSelectedProductFromWishList(product: selectedProduct) { deletedSuccess in
                        if deletedSuccess{
                            print("deleted success")
                        }else{
                            print("deleted failed")
                        }
                    }
                }
            }
        }
    }
    
    func checkIfProductFoundInWishList(productID: Int, completion: @escaping (Bool) -> Void){
        coreDataServices.getAllWishListProduct { productList, error in
            guard let productList = productList, let customerID = Helper.shared.getUserID()  else { return }
            for selectedProduct in productList{
                if selectedProduct.customerID == customerID && selectedProduct.productID == productID {
                    completion(true)
                }
            }
        }
    }
}
