//
//  ShoppingCart.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-21.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import Foundation
class ShoppingCart{
    public static let shoppingCart = ShoppingCart()
    var quantity: Int?
    var cartItems = [String:(Product,Int)]()
    private init(){
        
    }
    func addProductToCart(productId: String, product: Product, quantity: Int){
        //check if the product exists or not
        if let checkCart = cartItems[productId]{
            self.quantity = checkCart.1 + quantity
            cartItems[productId] = (product,self.quantity!)
        }else{
            cartItems[productId] = (product,quantity)
        }
    }
  
     func getItemsInCart() -> Dictionary<String, (Product,Int)> {
        return cartItems
    }
    
    func getCartCount() -> Int {
        return cartItems.count
    }
    
    //calculate total price
    func getTotalPrice() -> Double {
        var totalPrice: Double = 0
        for(id,products) in cartItems{
            totalPrice =  totalPrice + ((Double)(products.0.price) * Double(products.1))
        }
        return totalPrice
    }
    
    func removeEverythingFromCart(){
        cartItems.removeAll()
    }
    
    func removeProductFromCart(id: Int){
        if let cartCheck = cartItems["\(id)"]{
            cartItems.removeValue(forKey: "\(id)")
        }
    }
}
