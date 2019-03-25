//
//  ConfirmationViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-25.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var lblsuburb: UILabel!
    @IBOutlet weak var lblPostCode: UILabel!
    @IBOutlet weak var streetName: UILabel!
    var address: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        streetName.text = self.address
        lblsuburb.text = ""
        lblPostCode.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func keepShoppingButton(_ sender: UIButton) {
        navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
    }

}
