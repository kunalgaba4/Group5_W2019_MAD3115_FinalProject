//
//  ProfileViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-23.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addLeftRightNavigation()
    }
    
    func addLeftRightNavigation()
    {
        self.tabBarController!.navigationItem.hidesBackButton = true
        let buttonCheckout = UIBarButtonItem(title: NSLocalizedString("Logout", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileViewController.logOut))
        self.tabBarController!.navigationItem.rightBarButtonItem = buttonCheckout
        // let buttonProduct = UIBarButtonItem(title: NSLocalizedString("Continue", comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(HomeViewController.product))
        //        self.navigationItem.leftBarButtonItem = buttonProduct
    }
    
    
    @objc func product(){
        print("Product")
    }
    
    @objc func logOut(){
        ShoppingCart.shoppingCart.removeEverythingFromCart()
        var delegate : UpdateLoginProtocol
        delegate = self.navigationController?.viewControllers.first as! UpdateLoginProtocol
        delegate.updateLogin()
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
