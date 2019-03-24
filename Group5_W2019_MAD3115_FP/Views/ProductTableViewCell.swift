//
//  ProductTableViewCell.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-19.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var ivProductImage: UIImageView!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureEachCell(product: Product){
        self.lblProductName.text="\(product.description)"
        self.lblProductPrice.text = "$ Price :\(product.price)"
        var check = UIImage(named: product.imgURL)
        self.ivProductImage.image = check
    }

}
