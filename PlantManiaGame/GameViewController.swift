//
//  GameViewController.swift
//  PlantManiaGame
//
//  Created by Emily Chang on 4/22/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var current_plant: UIImageView!
    
    @IBOutlet weak var plant_age: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        current_plant.image = UIImage(named: Cactus.third_stage)
        plant_age.text = String(Cactus.age) + " Days Old"

    }


}
