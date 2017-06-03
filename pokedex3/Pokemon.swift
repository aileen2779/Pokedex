//
//  Pokemon.swift
//  pokedex3


import Foundation
import Alamofire

class ShifterClass {
    
    private var _name: String!
    private var _userName: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _address1: String!
    private var _city: String!
    private var _state: String!
    private var _zip: String!
    private var _country: String!
    private var _phone1: String!
    private var _emergencyName: String!
    private var _emergencyNum: String!
    private var _email: String!
    
    var userName: String {
        if _userName == nil {
            _userName = ""
        }
        return _userName
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var address1: String {
        if _address1 == nil {
            _address1 = ""
        }
        return _address1
    }
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        return _city
    }
    
    var state: String {
        if _state == nil {
            _state = ""
        }
        return _state
    }
    
    var zip: String {
        if _zip == nil {
            _zip = ""
        }
        return _zip
    }
    
    var country: String {
        if _country == nil {
            _country = ""
        }
        return _country
    }
    
    var emergencyName: String {
        if _emergencyName == nil {
            _emergencyName = ""
        }
        return _emergencyName
    }
    
    var emergencyNum: String {
        if _emergencyNum == nil {
            _emergencyNum = ""
        }
        return _emergencyNum
    }
    
    var phone1: String {
        if _phone1 == nil {
            _phone1 = ""
        }
        return _phone1
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    var email: String {
        if _email == nil {
            _email = ""
        }
        return _email
    }
    
    init(name: String,
         pokedexId: Int,
         userName: String,
         address1: String,
         city: String,
         state: String,
         zip: String,
         country: String,
         emergencyName: String,
         emergencyNum: String,
         phone1: String,
         email: String
        ) {
        
        self._name = name
        self._pokedexId = pokedexId
        self._userName = userName
        self._address1 = address1
        self._city = city
        self._state = state
        self._zip = zip
        self._country = country
        self._emergencyName = emergencyName
        self._emergencyNum = emergencyNum
        self._phone1 = phone1
        self._email = email
        
    }
    
}

