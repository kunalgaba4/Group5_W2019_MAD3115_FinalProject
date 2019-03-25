//
//  ProfileViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-23.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
    }
    

    @IBAction func updateUserInfo(_ sender: UIButton) {
        Update()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "Profile"
        addLeftRightNavigation()
    }
    
    func fetchUserDetails(){
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.firstNameTextField.text = value?["firstName"] as? String ?? ""
            self.lastNameTextField.text = value?["lastName"] as? String ?? ""
            self.phoneTextField.text = value?["phone"] as? String ?? ""
            self.emailTextField.text = value?["email"] as? String ?? ""
            self.zipTextField.text = value?["zip"] as? String ?? ""
            self.stateTextField.text = value?["state"] as? String ?? ""
            self.countryTextField.text = value?["country"] as? String ?? ""
            self.streetAddressTextField.text = value?["streetAddress"] as? String ?? ""
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func addLeftRightNavigation(){
        self.navigationItem.hidesBackButton = false
        let buttonCheckout = UIBarButtonItem(title: NSLocalizedString("Logout", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileViewController.logOut))
        self.tabBarController!.navigationItem.rightBarButtonItem = buttonCheckout
         let buttonProduct = UIBarButtonItem(title: NSLocalizedString("Update", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileViewController.Update))
                self.navigationItem.leftBarButtonItem = buttonProduct
    }
    
    
    @objc func Update(){
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            let firstName = firstNameTextField!.text
            if (firstName?.isEmpty)! || (firstName?.contains(""))!{
                return
            }
            let lastName = lastNameTextField.text
            if (lastName?.isEmpty)! || (lastName?.contains(""))!{
                return
            }
            let email = emailTextField.text
            
            if (!(email?.isValidEmail())!){
                showAlert(title: "Errorr", message: "Please enter valid email")
                return
            }
            let ph = phoneTextField.text
            if (ph?.isEmpty)! || (ph?.contains(""))!{
                return
            }
            if (ph?.count)!<10{
                return
            }
            let streetAddress = streetAddressTextField!.text
            if (streetAddress?.isEmpty)! || (streetAddress?.contains(""))!{
                return
            }
            let zip = zipTextField.text
            if (zip?.isEmpty)! || (zip?.contains(""))!{
                return
            }
            if (zip?.count)!<6{
                return
            }
            
            let state = stateTextField.text
            if (state?.isEmpty)! || (state?.contains(""))!{
                return
            }
            
            let country = countryTextField.text
            if (country?.isEmpty)! || (country?.contains(""))!{
                return
            }
            
            Database.database().reference().child("users").child((user?.uid)!).updateChildValues(
                ["email": email!, "firstName": firstName!,"phone": ph!,"lastName": lastName!,"streetAddress": streetAddress!,"zip":zip!, "state":state!,"country": country!], withCompletionBlock: { (error, ref) in
                    if let error = error {
                        print("Failed to update database values with error: ", error.localizedDescription)
                        return
                    }else{
                        self.showAlert(title: "Updated", message: "User info Updated")
                    }
            })
        } else {
            showAlert(title: "Eroor", message: "No user signed In")
        }
    }
    
    @objc func logOut(){
        ShoppingCart.shoppingCart.removeEverythingFromCart()
        var delegate : UpdateLoginProtocol
        delegate = self.navigationController?.viewControllers.first as! UpdateLoginProtocol
        delegate.updateLogin()
        do{
          try Auth.auth().signOut()
        }catch{
            print("Unable to logout")
        }
        self.navigationController?.popToRootViewController(animated: true)
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
