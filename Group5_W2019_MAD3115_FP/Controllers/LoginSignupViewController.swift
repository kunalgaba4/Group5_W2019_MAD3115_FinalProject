//
//  LoginSignupViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-24.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit
import  Firebase

enum AMLoginSignupViewMode {
    case login
    case signup
}


class LoginSignupViewController: UIViewController, UpdateLoginProtocol {
   
    
    
    let animationDuration = 0.25
    var mode:AMLoginSignupViewMode = .signup
    
    
    //MARK: - background image constraints
    @IBOutlet weak var backImageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var backImageBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    //MARK: - login views and constrains
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginContentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginWidthConstraint: NSLayoutConstraint!
    
    
    //MARK: - signup views and constrains
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var signupContentView: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupButtonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var signupButtonTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - logo and constrains
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoButtomInSingupConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoCenterConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var forgotPassTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var socialsView: UIView!
    
    
    //MARK: - input views
    @IBOutlet weak var loginEmailInputView: AMInputView!
    @IBOutlet weak var loginPasswordInputView: AMInputView!
    @IBOutlet weak var signupEmailInputView: AMInputView!
    @IBOutlet weak var signupPasswordInputView: AMInputView!
    @IBOutlet weak var signupPasswordConfirmInputView: AMInputView!
    
    
    
    //MARK: - controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // set view to login mode
        toggleViewMode(animated: false)
        //add keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        userRememberCheck()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        userRememberCheck()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateLogin() {
        print("Method is called")
        if rememberMeSwitch.isOn{
            if let email = UserDefaults.standard.string(forKey: "userEmail"){
                loginEmailInputView.textFieldView.text = email
                if let pass = UserDefaults.standard.string(forKey: "pass"){
                    loginPasswordInputView.textFieldView.text = pass
                    rememberMeSwitch.setOn(true, animated: false)
                }else{
                    rememberMeSwitch.setOn(false, animated: false)
                }
            }
        }else{
            let userdefault = UserDefaults.standard
            userdefault.removeObject(forKey: "userEmail")
            userdefault.removeObject(forKey: "pass")
            loginEmailInputView.textFieldView.text = ""
            loginPasswordInputView.textFieldView.text = ""
        }
    }
    
    
    func userRememberCheck(){
        if let email = UserDefaults.standard.string(forKey: "userEmail"){
            loginEmailInputView.setViewExpandMode(expand: true)
            loginPasswordInputView.setViewExpandMode(expand: true)
            loginEmailInputView.textFieldView.text = email
            if let pass = UserDefaults.standard.string(forKey: "pass"){
                loginPasswordInputView.textFieldView.text = ""
                loginPasswordInputView.textFieldView.text = pass
                rememberMeSwitch.setOn(true, animated: false)
            }else{
                rememberMeSwitch.setOn(false, animated: false)
            }
        }
    }

    
    
    //MARK: - button actions
    @IBAction func loginButtonTouchUpInside(_ sender: AnyObject) {
        
        if mode == .signup {
            toggleViewMode(animated: true)
            
        }else{
            
            let userOrEmail = loginEmailInputView.textFieldView.text
            let password = loginPasswordInputView.textFieldView.text
            if (userOrEmail!.isEmpty || userOrEmail!.contains("")){
                showAlert(title: "Error !!", message: "Please Enter Valid Email or Username")
                return
            }
            
            if (!(userOrEmail?.isValidEmail())!){
                showAlert(title: "Error !!", message: "Please Enter Valid Email or Username")
                return
            }
            
            if (password!.isEmpty) || (password!.contains("")) {
                showAlert(title: "Error !!", message: "Please Enter Valid Password")
                return
            }
            if (!(password?.isValidPassword())!){
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
        }
    }
    
    func  showHomeView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let parent = sb.instantiateViewController(withIdentifier: "parent")
        self.navigationController?.pushViewController(parent, animated: true)
    }
    
    @IBAction func signupButtonTouchUpInside(_ sender: AnyObject) {
        
        if mode == .login {
            toggleViewMode(animated: true)
        }else{
            let userOrEmail = signupEmailInputView.textFieldView.text
            let password = signupPasswordInputView.textFieldView.text
            let confirmPass = signupPasswordConfirmInputView.textFieldView.text
            validateUserCredentials(userOrEmail: userOrEmail!, password: password!, confPass: confirmPass!)
            createUser(email: userOrEmail!, password: password!)
        }
    }
    
    func validateUserCredentials(userOrEmail: String, password: String, confPass: String){
        
        if (userOrEmail.isEmpty || userOrEmail.contains("")){
            showAlert(title: "Error !!", message: "Please Enter Valid Email or Username")
            return
        }
        
        if (!(userOrEmail.isValidEmail())){
            showAlert(title: "Error !!", message: "Please Enter Valid Email or Username")
            return
        }
        
        if (password.isEmpty) || (password.contains("")) {
            showAlert(title: "Error !!", message: "Please Enter Valid Password")
            return
        }
        
        if (!(password.isValidPassword())){
            showAlert(title: "Error !!", message: "Please Enter Valid Password")
            return
        }
        if (confPass.isEmpty) || (confPass.contains("")) {
            showAlert(title: "Error !!", message: "Confirm pAssword does not match")
            return
        }
        if password != confPass{
            return
        }
    }
    func createUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to sign user up with error: ", error.localizedDescription)
                self.showAlert(title: "Error !!", message: "Failed to signup")
                return
            }else{
                self.showAlert(title: "Congratulations!!", message: "Your account is created.")
                self.signupEmailInputView.textFieldView.text = ""
                self.signupPasswordInputView.textFieldView.text = ""
                self.signupPasswordConfirmInputView.textFieldView.text = ""
            }
        }
    }
    
    
    
    //MARK: - toggle view
    func toggleViewMode(animated:Bool){
        
        // toggle mode
        mode = mode == .login ? .signup:.login
        
        
        // set constraints changes
        backImageLeftConstraint.constant = mode == .login ? 0:-self.view.frame.size.width
        
        
        loginWidthConstraint.isActive = mode == .signup ? true:false
        logoCenterConstraint.constant = (mode == .login ? -1:1) * (loginWidthConstraint.multiplier * self.view.frame.size.width)/2
        if mode == .login{
            loginButtonVerticalCenterConstraint.priority = UILayoutPriority(rawValue: 300)
        }else{
            loginButtonVerticalCenterConstraint.priority = UILayoutPriority(rawValue: 300)

        }
        
        if mode == .signup{
            signupButtonVerticalCenterConstraint.priority = UILayoutPriority(rawValue: 300)
        }else{
            signupButtonVerticalCenterConstraint.priority = UILayoutPriority(rawValue: 900)
        }
        
        
        //animate
        self.view.endEditing(true)
        
        UIView.animate(withDuration:animated ? animationDuration:0) {
            
            //animate constraints
            self.view.layoutIfNeeded()
            
            //hide or show views
            self.loginContentView.alpha = self.mode == .login ? 1:0
            self.signupContentView.alpha = self.mode == .signup ? 1:0
            
            
            // rotate and scale login button
            let scaleLogin:CGFloat = self.mode == .login ? 1:0.4
            let rotateAngleLogin:CGFloat = self.mode == .login ? 0:CGFloat(-Double.pi/2)
            
            var transformLogin = CGAffineTransform(scaleX: scaleLogin, y: scaleLogin)
            transformLogin = transformLogin.rotated(by: rotateAngleLogin)
            self.loginButton.transform = transformLogin
            
            
            // rotate and scale signup button
            let scaleSignup:CGFloat = self.mode == .signup ? 1:0.4
            let rotateAngleSignup:CGFloat = self.mode == .signup ? 0:CGFloat(-Double.pi/2)
            
            var transformSignup = CGAffineTransform(scaleX: scaleSignup, y: scaleSignup)
            transformSignup = transformSignup.rotated(by: rotateAngleSignup)
            self.signupButton.transform = transformSignup
        }
        
    }
    
    
    //MARK: - keyboard
    @objc func keyboarFrameChange(notification:NSNotification){
        
        let userInfo = notification.userInfo as! [String:AnyObject]
        
        // get top of keyboard in view
        let topOfKetboard = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue .origin.y
        
        
        // get animation curve for animate view like keyboard animation
        var animationDuration:TimeInterval = 0.25
        var animationCurve:UIView.AnimationCurve = .easeOut
        if let animDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            animationDuration = animDuration.doubleValue
        }
        
        if let animCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            animationCurve =  UIView.AnimationCurve.init(rawValue: animCurve.intValue)!
        }
        
        
        // check keyboard is showing
        let keyboardShow = topOfKetboard != self.view.frame.size.height
        
        
        //hide logo in little devices
        let hideLogo = self.view.frame.size.height < 667
        
        // set constraints
        backImageBottomConstraint.constant = self.view.frame.size.height - topOfKetboard
        
        logoTopConstraint.constant = keyboardShow ? (hideLogo ? 0:20):50
        logoHeightConstraint.constant = keyboardShow ? (hideLogo ? 0:40):60
        logoBottomConstraint.constant = keyboardShow ? 20:32
        logoButtomInSingupConstraint.constant = keyboardShow ? 20:32
        
        forgotPassTopConstraint.constant = keyboardShow ? 30:45
        
        loginButtonTopConstraint.constant = keyboardShow ? 25:30
        signupButtonTopConstraint.constant = keyboardShow ? 23:35
        
        loginButton.alpha = keyboardShow ? 1:0.7
        signupButton.alpha = keyboardShow ? 1:0.7
        
        
        
        // animate constraints changes
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
        
    }
    
    //MARK: - hide status bar in swift3
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
