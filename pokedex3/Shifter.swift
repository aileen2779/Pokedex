//
//  Pokemon.swift
//  pokedex3
//
//  Created by Jonny B on 7/23/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import Foundation
import Alamofire


class Shifter {
    
    private var _userLogin: String!
    private var _id: String!
    
   
    var id: String {
        return _id
    }
    
    var userLogin: String {
        return _userLogin
    }
    
    init(id: String, userLogin: String) {
        
        self._id = id
        self._userLogin = userLogin
        
    }
    
    
    func downloadShifterDetail(completed: @escaping DownloadComplete) {
        Alamofire.request("http://www.702shifters.com/json_allusers.php").responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let id = dict["id"] as? String {
                    self._id = id
                }
                
                if let userLogin = dict["user_login"] as? String {
                    self._userLogin = userLogin
                }
                
                
                print(self._id)
                print(self._userLogin)
                
                
            }
            
            completed()
        }
    }
    
}
