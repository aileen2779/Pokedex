//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Jonny B on 7/23/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var shifter: ShifterClass!
    

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var emerNameLabel: UILabel!
    @IBOutlet weak var emerNumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var userIdText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var address1Text: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var emerNameText: UITextField!
    @IBOutlet weak var emerNumText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    @IBAction func memberNonMember(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.updateUI()
        } else {
            self.updateUIWithMember()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = shifter.name.capitalized
        
        let img = UIImage(named: "\(shifter.userId)")
        
        mainImg.image = img

        //pokedexLbl.text = "\(pokemon.pokedexId)"
        self.updateUI()
        
        //pokemon.downloadPokemonDetail {
        //    self.updateUI()
        //}
        
    }
    
    func updateUIWithMember() {
        userIdText.text     = ""
        phoneText.text      = ""
        address1Text.text   = ""
        cityText.text       = ""
        stateText.text      = ""
        zipText.text        = ""
        countryText.isHidden = false
        emerNameText.isHidden = false
        emerNumText.isHidden = false
        emailText.isHidden  = false

        
        userIdText.text     = shifter.userName
        phoneText.text      = shifter.phone1
        address1Text.text   = shifter.address1
        cityText.text       = shifter.city
        stateText.text      = shifter.state
        zipText.text        = shifter.zip
        countryText.text    = shifter.country
        emerNameText.text   = shifter.emergencyName
        emerNumText.text    = shifter.emergencyNum
        emailText.text      = shifter.email
        
        userIdLabel.text    = "User ID   "
        phoneLabel.text     = "Phone     "
        addressLabel.text   = "Address  "
        cityLabel.text      = "City          "
        stateLabel.text     = "State       "
        zipLabel.text       = "  Zip   "
        countryLabel.text   = "Country  "
        emerNameLabel.text  = "Emer. Name "
        emerNumLabel.text   = "Emer. Phone "
        emailLabel.text     = "Email      "
    }

    func updateUI() {
        userIdText.text     = ""
        phoneText.text      = ""
        address1Text.text   = ""
        cityText.text       = ""
        stateText.text      = "01/01/1999"
        zipText.text        = "01/01/2000"
        countryText.isHidden = true
        emerNameText.isHidden = true
        emerNumText.isHidden = true
        emailText.isHidden  = true
        
        userIdLabel.text    = "Membership    "
        phoneLabel.text     = "Payment          "
        addressLabel.text   = "Payment Type  "
        cityLabel.text      = "Status        "
        stateLabel.text     = "Start  "
        zipLabel.text       = "  Expire  "
        countryLabel.text   = ""
        emerNameLabel.text  = ""
        emerNumLabel.text   = ""
        emailLabel.text     = ""
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
