//
//  ParentTabBarViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-23.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class ParentTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
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
