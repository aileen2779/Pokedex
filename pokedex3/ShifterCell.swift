//
//  PokeCell.swift
//  pokedex3
//
//  Created by Jonny B on 7/23/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var shifter: ShifterClass!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 7.0
    }
    
    
    func configureCell(_ shifter: ShifterClass) {
        
        self.shifter = shifter
        
        nameLbl.text = self.shifter.name.capitalized
        thumbImg.image = UIImage(named: "\(self.shifter.userId)")
        
    }
    
    
    
}
