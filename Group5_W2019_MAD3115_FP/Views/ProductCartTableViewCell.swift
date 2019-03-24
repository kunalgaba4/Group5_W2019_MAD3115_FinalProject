//
//  ProductCartTableViewCell.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-22.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class ProductCartTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductQuantity: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var ivProductImage: UIImageView!
    var productDictionary :(Product,Int)?
    var totalPrice: Double = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(product: (Product,Int)){
    self.productDictionary = product
        self.lblProductName.text = productDictionary!.0.name
        self.lblProductPrice.text = "Price :$\(getTotalProductPrice())"
        self.lblProductQuantity.text = "Quantity :\(productDictionary!.1)"
        self.ivProductImage.image = UIImage(named: (productDictionary?.0.imgURL)!)
    }
    
    func getTotalProductPrice() -> Double {
        if let p = productDictionary{
            self.totalPrice = p.0.price * Double(p.1)
        }
        return totalPrice
        
    }

}
