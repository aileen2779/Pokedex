//
//  MainController.swift
//  702Shifters
//
//  Created by Gamy Malasarte on 6/6/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITextFieldDelegate {

    
    
    let url  = "http://www.702shifters.com/ios_auth.php"
    
    //@IBOutlet weak var username_input: UITextField!
    //@IBOutlet weak var password_input: UITextField!
    //@IBOutlet weak var login_button: UIButton!
    
    @IBOutlet weak var login_button: UIButton!
    
    var login_session:String = ""
    
    @IBOutlet weak var loginTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!

    var searchURL = URL(string: "http://www.702shifters.com?user=gamy&pass=gamy666")
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = loginTextField.text!
        let userPassword = passwordTextField.text!
        // Check for empty fields
        if (userEmail.isEmpty) {
            
            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.loginTextField.center.x += 10 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.loginTextField.center.x -= 20 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.loginTextField.center.x += 10 }, completion: nil)
            
            return
        }
        
        if (userPassword.isEmpty) {

            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.passwordTextField.center.x += 10 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.passwordTextField.center.x -= 20 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.passwordTextField.center.x += 10 }, completion: nil)
            
            return
        }
        
        //if (wpAuthenticate(loginTextField, passwordTextField)){
         //   self.performSegue(withIdentifier: "ShifterPokedexVC", sender: self)
       // }
        
        if(login_button.titleLabel?.text == "Logout") {
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "session")
            
            LoginToDo()
        } else {
            login_now(username:loginTextField.text!, password: passwordTextField.text!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init routine to hide keyboard
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil {
            login_session   = preferences.object(forKey: "session") as! String
            check_session()
        
        } else {
            LoginToDo()
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
            print("login \(server_response)");
            
            if let data_block = server_response["data"] as? NSDictionary {
                if let session_data = data_block["session"] as? String
                {
                    self.login_session = session_data
                    
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async(execute: self.LoginDone)
                }
            }
            
        })
        
        task.resume()
        
        
    }
    
    
    
    func LoginDone() {
        //loginTextField.isEnabled = false
        //passwordTextField.isEnabled = false
        
        //login_button.isEnabled = true
        
        
        //login_button.setTitle("Logout", for: .normal)
        
        self.performSegue(withIdentifier: "ShifterPokedexVC", sender: self)
    }
    
    func LoginToDo()
    {
        loginTextField.isHidden = false
        passwordTextField.isHidden = false
        login_button.isHidden = false

        loginTextField.isEnabled = true
        passwordTextField.isEnabled = true
        login_button.isEnabled = true
        
        
        login_button.setTitle("Login", for: .normal)
    }
    
    
    func check_session()
    {
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
        
        
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        print(paramString)
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
                    DispatchQueue.main.async(execute: self.LoginDone)
                    
                } else {
                    DispatchQueue.main.async(execute: self.LoginToDo)
                }
            }
        })
        
        task.resume()
        
    }
    

}





