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
    
    
}
