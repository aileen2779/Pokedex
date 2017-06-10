//
//  MainController.swift
//  702Shifters
//
//  Created by Gamy Malasarte on 6/6/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var splashLogo: UIImageView!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var loginTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!

    let url  = URL_AUTH
    
    var login_session:String = ""
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // disable login button to prevent launching segue twice
        login_button.isEnabled = false
        
        // evaluate login and password
        let userEmail = loginTextField.text!
        let userPassword = passwordTextField.text!
        
        // Check for empty fields
        if (userEmail.isEmpty) {
            animateMe(textField: self.loginTextField)
            
            login_button.isEnabled = true
            return
        }
        
        if (userPassword.isEmpty) {

            animateMe(textField: self.passwordTextField)
            login_button.isEnabled = true
            return
        }
        
        login_now(username:loginTextField.text!, password: passwordTextField.text!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check if already logged in after logged out
        // if not logged in, show login and password prompt
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") == nil {
            loginToDo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init routine to hide keyboard
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // redirect if logged in or not
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil {
            login_session   = preferences.object(forKey: "session") as! String
            check_session()
        
        } else {
            loginToDo()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    
    func login_now(username:String, password:String) {
        let post_data: NSDictionary = NSMutableDictionary()
        
        post_data.setValue(username, forKey: "username")
        post_data.setValue(password, forKey: "password")
        
        let url:URL = URL(string: self.url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        
        for (key, value) in post_data {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            
            let json: Any?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                return
            }
            
            guard let server_response = json as? NSDictionary else {
                return
            }
            
            if let data_block = server_response["data"] as? NSDictionary {
                if let session_data = data_block["session"] as? String {
                    self.login_session = session_data
                    
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async(execute: self.loginDone)
                }
            }
            
        })
        
        task.resume()
        
        
    }

    
    func loginDone() {
        self.performSegue(withIdentifier: "ShifterPokedexVC", sender: self)
        
        // Enable login button before segue
        login_button.isEnabled = true
  
    }
    
    
    func animateMe(textField: UITextField) {
        
        let _thisTextField = textField

        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {_thisTextField.center.x += 10 }, completion: nil)
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {_thisTextField.center.x -= 20 }, completion: nil)
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {_thisTextField.center.x += 10 }, completion: nil)
    }
    
    func loginToDo() {
        splashLogo.isHidden = true
        loginTextField.isHidden = false
        passwordTextField.isHidden = false
        login_button.isHidden = false
        
        loginTextField.isEnabled = true
        passwordTextField.isEnabled = true
        login_button.isEnabled = true
    }
    
    
    func check_session() {
        loginTextField.isHidden = true
        passwordTextField.isHidden = true
        login_button.isHidden = true
        
        let post_data: NSDictionary = NSMutableDictionary()
        
        post_data.setValue(login_session, forKey: "session")
        
        let url:URL = URL(string: self.url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        
        for (key, value) in post_data {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                return
            }
            
            
            let json: Any?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                return
            }
            
            guard let server_response = json as? NSDictionary else {
                return
            }
            
            print("check \(server_response)");
            
            if let response_code = server_response["response_code"] as? Int  {
                if(response_code == 200) {
                    DispatchQueue.main.async(execute: self.loginDone)
                    
                } else {
                    DispatchQueue.main.async(execute: self.loginToDo)
                }
            }
        })
        
        task.resume()
        
    }
    

}





