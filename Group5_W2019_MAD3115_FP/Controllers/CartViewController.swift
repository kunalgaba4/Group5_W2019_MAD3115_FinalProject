//
//  CartViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-21.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var arr = [(Product,Int)]()
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet weak var tableViewCart: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCart.delegate = self
        tableViewCart.dataSource = self
        self.navigationItem.title = "Cart Details"
        addLeftRightNavigation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "Cart"

        //To reduce redundancy
        if arr.count>0{
            arr.removeAll()
        }
        let dicOfpRoductsInCart = ShoppingCart.shoppingCart.getItemsInCart()
        for (key, value) in dicOfpRoductsInCart {
            arr.append(value)
        }
        tableViewCart.reloadData()
        displayTotal()
        addLeftRightNavigation()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCartCell") as! ProductCartTableViewCell
        var productTuple = arr[indexPath.row]
        cell.configureCell(product: productTuple)
        return cell    }
    
    func displayTotal() {
        self.totalLabel.text = "$" + String(format: "%.2f", ShoppingCart.shoppingCart.getTotalPrice())
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ShoppingCart.shoppingCart.removeProductFromCart(id: arr[indexPath.row].0.id)
            arr.remove(at: indexPath.row)
            do{
                tableViewCart.reloadData()
                displayTotal()
            }
            catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            if arr.count == 0 {
                self.tableViewCart.setEditing(false, animated: true)
            }
            
        }
    }
    
    func addLeftRightNavigation()
    {
        self.tabBarController!.navigationItem.hidesBackButton = true
                let buttonCheckout = UIBarButtonItem(title: NSLocalizedString("Checkout", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(CartViewController.checkout))
                self.tabBarController!.navigationItem.rightBarButtonItem = buttonCheckout
//  let buttonProduct = UIBarButtonItem(title: NSLocalizedString("Continue", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(HomeViewController.product))
        //        self.navigationItem.leftBarButtonItem = buttonProduct
    }
    
    
    @objc func product()
    {
        print("Product")
      
        
    }
    @objc func checkout(){
        if arr.count == 0{
            showAlert(title: "Sorry", message: "There is nothing to checkout")
            return
        }

        let checkOutVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckOutViewController
        self.navigationController?.pushViewController(checkOutVc, animated: true)
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
