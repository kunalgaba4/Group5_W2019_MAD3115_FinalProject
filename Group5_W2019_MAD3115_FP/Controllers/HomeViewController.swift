//
//  HomeViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-19.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var jsonString = """
[{"id":1,"imgUrl":"https://guesseu.scene7.com/is/image/GuessEU/M63H24W7JF0-L302-ALTGHOST?wid=1500&fmt=jpeg&qlt=80&op_sharpen=0&op_usm=1.0,1.0,5,0&iccEmbed=0","name":"CHECK PRINT SHIRT","price":110,"Description":"Add desc here"},{"id":2,"imgUrl":"https://guesseu.scene7.com/is/image/GuessEU/FLGLO4FAL12-BEIBR?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0","name":"GLORIA HIGH LOGO SNEAKER","price":91,"Description":"Add desc here"},{"id":3,"imgUrl":"https://guesseu.scene7.com/is/image/GuessEU/HWVG6216060-TAN?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0","name":"CATE RIGID BAG","price":94.5,"Description":"Add desc here"},{"id":4,"imgUrl":"http://guesseu.scene7.com/is/image/GuessEU/WC0001FMSWC-G5?wid=520&fmt=jpeg&qlt=80&op_sharpen=0&op_usm=1.0,1.0,5,0&iccEmbed=0","name":"GUESS CONNECT WATCH","price":438.9,"Description":"Add desc here"},{"id":5,"imgUrl":"https://guesseu.scene7.com/is/image/GuessEU/AW6308VIS03-SAP?wid=700&amp;fmt=jpeg&amp;qlt=80&amp;op_sharpen=0&amp;op_usm=1.0,1.0,5,0&amp;iccEmbed=0","name":"'70s RETRO GLAM KEFIAH","price":20,"Description":"Add desc here"}]
"""
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "All Products"
        addLeftRightNavigation()
    }
    
    
    @IBOutlet weak var tvProduct: UITableView!
    var allProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvProduct.delegate = self
        tvProduct.dataSource = self
        addLeftRightNavigation()
        
        //to get the data from json
//        if let json = jsonString.data(using: .utf8){
//            let decoder = JSONDecoder()
//            do{
//                allProducts = try decoder.decode([Prod].self, from: json)
//            }catch{
//                print(error.localizedDescription)
//            }
//        }
//
        
        
        if  let path = Bundle.main.path(forResource: "ProductList", ofType: "plist"),
            let xml  = FileManager.default.contents(atPath: path),
            let preferences = try? PropertyListDecoder().decode([Product].self, from: xml){
            allProducts = preferences
        }
        
    }
    
    func addLeftRightNavigation(){
        self.tabBarController!.navigationItem.hidesBackButton = true
        let buttonCheckout = UIBarButtonItem(title: NSLocalizedString("About Us", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(HomeViewController.checkout))
        self.tabBarController!.navigationItem.rightBarButtonItem = buttonCheckout
    }
    
    
    @objc func checkout()
    {
        let checkOutVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.navigationController?.pushViewController(checkOutVc, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "product_details":
            let productDetailsController = segue.destination as! ProductDetailsViewController
            if let indexPath = self.tvProduct.indexPathForSelectedRow {
                productDetailsController.configureProductDescription(product: allProducts[indexPath.row])
            }
        default:
            break
        }
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let product = allProducts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        //cell.configureEachCell(product: product)
        
        let p = self.allProducts[indexPath.row]
        cell.configureEachCell(product: p)
        return cell
        
    }
}
