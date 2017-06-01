//
//  ViewController.swift
//  pokedex3
//
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shifter = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    var searchURL = URL_BASE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        callJSONURL(jsonUrl: searchURL!)
        //collection.reloadData()
    }

    func callJSONURL(jsonUrl: URL) {
        let url = jsonUrl
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print ("ERROR")
            } else  {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyObject]
                        
                        var x = 0
                        //print(myJson)
                        repeat {
                            var dict2  = myJson[x] as! [String : String]
                            
                            let pokeId      = Int(dict2["user_id"]!)!
                            let userName    = String(dict2["user_name"]!)!
                            let address1    = String(dict2["addr1"]!)!
                            let city        = String(dict2["city"]!)!
                            let state       = String(dict2["state"]!)!
                            let zip         = String(dict2["zip"]!)!
                            let country     = String(dict2["country"]!)!
                            let emergencyName = String(dict2["emer_contact_name"]!)!
                            let emergencyNum = String(dict2["emer_contact_number"]!)!
                            let phone1 = String(dict2["phone1"]!)!
                            let name = "\(dict2["first_name"]!.lowercased()) \(dict2["last_name"]!.lowercased())"
                            let shifter = Pokemon(name: name,
                                                pokedexId: pokeId,
                                                userName: userName,
                                                address1: address1,
                                                city: city,
                                                state: state,
                                                zip: zip,
                                                country: country,
                                                emergencyName: emergencyName,
                                                emergencyNum: emergencyNum,
                                                phone1: phone1
                            )
                            self.shifter.append(shifter)
                            x += 1
                        } while ( x < myJson.count)
                        self.shifter.sort(by: {$0.name < $1.name})
                        self.collection.reloadData()
                    } catch {
                        print("done")
                    }
                }
            }
        }
        task.resume()
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let shiftClassVar: Pokemon!
            if inSearchMode {
                shiftClassVar = filteredPokemon[indexPath.row]
                cell.configureCell(shiftClassVar)
            } else {
                shiftClassVar = shifter[indexPath.row]
                cell.configureCell(shiftClassVar)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var shiftClassVar: Pokemon!
        
        if inSearchMode {
            shiftClassVar = filteredPokemon[indexPath.row]
        } else {
            shiftClassVar = shifter[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailVC", sender: shiftClassVar)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return shifter.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = shifter.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let shiftClassVar = sender as? Pokemon {
                    detailsVC.pokemon = shiftClassVar
                }
            }
        }
        
    }
    
    
}

