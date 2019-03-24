//
//  CheckOutViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-23.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    
    
    @IBOutlet var cardNumber: UITextField!
    @IBOutlet var cardExpiryMonth: UITextField!
    @IBOutlet var cardExpiryYear: UITextField!
    @IBOutlet var cardCvv: UITextField!
    @IBOutlet var pickerPickupPoint: UIPickerView!
    
    @IBOutlet var tableViewOrderDetails: UITableView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet var labelTotalPrice: UILabel!
    let location = ["59 First Gulf Blvd", "25 Peel Centre Drive", "295 Queen St E", "17600 Yonge St", "1355 Kingston Road,"]
    var arr = [(Product,Int)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOrderDetails.delegate = self
        self.tableViewOrderDetails.dataSource = self
        self.pickerPickupPoint.delegate = self
        self.pickerPickupPoint.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.setHidesBackButton(false, animated: false)
        if arr.count>0{
            arr.removeAll()
        }
        let dicOfpRoductsInCart = ShoppingCart.shoppingCart.getItemsInCart()
        for (key, value) in dicOfpRoductsInCart {
            arr.append(value)
        }
        tableViewOrderDetails.reloadData()
        displayTotal()
    }
    

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return location.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return location[row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row].0.name
        cell.detailTextLabel?.text = "\(arr[indexPath.row].1) * \(arr[indexPath.row].0.price)"
        return cell
    }
    
    func displayTotal() {
        self.lblPrice.text = "$" + String(format: "%.2f", ShoppingCart.shoppingCart.getTotalPrice())
    }
    @IBAction func buttonPayNow(_ sender: Any) {
        if ShoppingCart.shoppingCart.getCartCount() == 0 {
            showAlert(title: "Error!!", message: "Your cart is empty.")
            return
        }
        else if (self.cardNumber.text?.isEmpty)! {
            showAlert(title: "Error!!", message: "Please enter your card number.")
            return
        }
        else if (self.cardExpiryMonth.text?.isEmpty)! {
            showAlert(title: "Error!!", message: "Please enter the expiry month of your card.")
            return

        }
        else if (self.cardExpiryYear.text?.isEmpty)! {
            showAlert(title: "Error!!", message: "Please enter the expiry year of your card.")
            return

        }
        else if (self.cardCvv.text?.isEmpty)!{
            showAlert(title: "Error!!", message: "Please enter the CVV number of your card.")
            return
        }
        else{
           showAlert(title: "Confirm Payment", message: "press ok to checkout")
        }
        
        self.cardNumber.text = ""
        self.cardExpiryMonth.text = ""
        self.cardExpiryYear.text = ""
        self.cardCvv.text = ""
        self.lblPrice.text = "$ 0.0"
        ShoppingCart.shoppingCart.removeEverythingFromCart()
        
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
