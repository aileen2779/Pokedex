//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Jonny B on 7/23/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var phoneLabel: UILabel!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!


    @IBOutlet weak var userIdText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var address1Text: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var emerNameText: UITextField!
    @IBOutlet weak var emerNumText: UITextField!
 
    @IBAction func memberNonMember(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.updateUI()
        } else {
            self.updateUIWithMember()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img

        //pokedexLbl.text = "\(pokemon.pokedexId)"
        self.updateUI()
        
        //pokemon.downloadPokemonDetail {
        //    self.updateUI()
        //}
        
    }
    
    func updateUI() {
        userIdText.text = pokemon.userName
        phoneText.text = pokemon.phone1
        address1Text.text = pokemon.address1
        cityText.text = pokemon.city
        stateText.text = pokemon.state
        zipText.text = pokemon.zip
        countryText.text = pokemon.country
        emerNameText.text = pokemon.emergencyName
        emerNumText.text = pokemon.emergencyNum
    }

    func updateUIWithMember() {
        userIdText.text = ""
        phoneText.text = ""
        address1Text.text = ""
        cityText.text = ""
        stateText.text = ""
        zipText.text = ""
        countryText.text = ""
        emerNameText.text = ""
        emerNumText.text = ""
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
