//
//  MainController.swift
//  702Shifters
//
//  Created by Gamy Malasarte on 6/6/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!

    var searchURL = URL(string: "http://www.702shifters.com?user=gamy&pass=gamy666")
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = loginTextField.text!
        let userPassword = passwordTextField.text!
        // Check for empty fields
        if (userEmail.isEmpty) {
            //Display alert message
            //displayMyAlertMessage(userMessage: "All fields are required")
            
            // Enable this if focus is removed
            //self.userEmailTextField.resignFirstResponder()
            
            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.loginTextField.center.x += 10 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.loginTextField.center.x -= 20 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.loginTextField.center.x += 10 }, completion: nil)
            
            return
        }
        
        if (userPassword.isEmpty) {
            // Display alert message
            //displayMyAlertMessage(userMessage: "All fields are required")
            
            // Enable this if focus is removed
            //self.userEmailTextField.resignFirstResponder()
            
            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.passwordTextField.center.x += 10 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.passwordTextField.center.x -= 20 }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {self.passwordTextField.center.x += 10 }, completion: nil)
            
            return
        }
        
        if (wpAuthenticate(loginTextField, passwordTextField)){
            self.performSegue(withIdentifier: "ShifterPokedexVC", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init routine to hide keyboard
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}


func wpAuthenticate(_ userTextField: UITextField, _ passTextField: UITextField) -> Bool {
    let _user = userTextField.text!
    let _pass = passTextField.text!
    
  //  var resultValue: String = ""
    
    // Store data mysql
    let myUrl = URL(string: "http://www.702shifters.com/ios_auth.php")
    var request = URLRequest(url:myUrl!)
    let postString = ("action=register&user=\(String(describing: _user))&pass=\(_pass)")

    request.httpMethod = "POST";
    request.httpBody = postString.data(using: String.Encoding.utf8)
    

    let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if error != nil {
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            if let parseJSON = json {
                
                // Now we can access value
                let resultValue = parseJSON["Response"] as? String
                print(resultValue!)
            }
        } catch {
            print(error)
        }
    }
    task.resume()
    
    return true
}


