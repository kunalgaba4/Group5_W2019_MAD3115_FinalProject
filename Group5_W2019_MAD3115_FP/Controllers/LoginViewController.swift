//
//  ViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-16.
//  Copyright © 2019 Cheeku. All rights reserved.
//commit check

import UIKit
import Firebase
class LoginViewController: UIViewController,UpdateLoginProtocol {
    func updateLogin() {
        print("Method is called")
        if rememberMeSwitch.isOn{
            if let email = UserDefaults.standard.string(forKey: "userEmail"){
                usernameTextField.text = email
                if let pass = UserDefaults.standard.string(forKey: "pass"){
                    passwordTextField.text = pass
                    rememberMeSwitch.setOn(true, animated: false)
                }else{
                    rememberMeSwitch.setOn(false, animated: false)
                }
            }
        }else{
            let userdefault = UserDefaults.standard
            userdefault.removeObject(forKey: "userEmail")
            userdefault.removeObject(forKey: "pass")
            usernameTextField.text = ""
            passwordTextField.text = ""
        }
    }
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userRememberCheck()
    }
    
    func userRememberCheck(){
        if let email = UserDefaults.standard.string(forKey: "userEmail"){
            usernameTextField.text = email
            if let pass = UserDefaults.standard.string(forKey: "pass"){
                passwordTextField.text = pass
                rememberMeSwitch.setOn(true, animated: false)
            }else{
                rememberMeSwitch.setOn(false, animated: false)
            }
        }
    }

    @IBAction func signInBtn(_ sender: UIButton) {
        let userOrEmail = usernameTextField.text
        let password = passwordTextField.text
        if (userOrEmail!.isEmpty || userOrEmail!.contains("")){
            showAlert(title: "Error !!", message: "Please Enter Valid Email or Username")
            return
        }
        
        if (password!.isEmpty) || (password!.contains("")) {
            showAlert(title: "Error !!", message: "Please Enter Valid Password")
            return
        }
        
        Auth.auth().signIn(withEmail: userOrEmail!, password: password!) { (result, error) in
            if let error = error {
                print("Failed to sign user in with error: ", error.localizedDescription)
                self.showAlert(title: "Error !!", message: "Id or password is Invalid")
                return
            }
            
            let userdefault = UserDefaults.standard
            if self.rememberMeSwitch.isOn {
                userdefault.set(userOrEmail,forKey:"userEmail")
                userdefault.set(password, forKey: "pass")
            }else{
                userdefault.removeObject(forKey: "userEmail")
                userdefault.removeObject(forKey: "pass")
            }
            self.showHomeView()
        }
        
        self.showHomeView()
        
        
        
    }
    func  showHomeView() {
//        performSegue(withIdentifier: "home", sender: nil)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let parent = sb.instantiateViewController(withIdentifier: "parent")
        self.navigationController?.pushViewController(parent, animated: true)
    }
    
    
    
    @IBAction func createAccountBtn(_ sender: UIButton) {
    }
}

extension UIViewController{
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

