//
//  ProductDetailsViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-19.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var ivProductImage: UIImageView!
    var productDetails: Product?
    var cartItems : [String:(Product,Int)]?
    
    
    var originalPrice: Double?
    var subTotalPrice: Double = 0.0
    var totalPrice: Double = 0.0
    var quantity: Int = 1
    
    @IBOutlet weak var lblQuantity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = self.productDetails {
            configureView(for: product, with: product.price)
            self.subTotalPrice = product.price
            self.totalPrice = product.price
        }
        // Do any additional setup after loading the view.
    }
    
    func configureProductDescription(product: Product){
        productDetails = product
        originalPrice = productDetails?.price
        
    }
    
    @IBAction func quantityStepper(_ sender: UIStepper) {
        quantity = Int(sender.value)
        updateTotalPrice()
    }
    
    
    func updateTotalPrice() {
        if let product = self.productDetails {
            totalPrice = subTotalPrice * Double(quantity)
            configureView(for: product, with: totalPrice)
        }
    }
    
    func configureView(for product: Product, with price: Double) {
        self.navigationItem.title = product.name
        self.navigationController!.navigationItem.title = product.name
        self.ivProductImage.image = UIImage(named: product.imgURL)
        self.lblProductName.text = product.name
        self.lblPrice.text = "$" + String(format: "%.2f", price)
//        self.productDescription.text = product.details
        self.lblQuantity.text = "Quantity: " + String(quantity)
    }

    @IBAction func buttonAddToCart(_ sender: UIButton) {
//        productDetails?.price = (Double)(totalPrice)
        ShoppingCart.shoppingCart.addProductToCart(productId: "\(productDetails!.id)", product: productDetails!, quantity: quantity)
        showAlert(title: "Added", message: "Product Successffully added to the cart")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
