//
//  GameViewController.swift
//  PlantManiaGame
//
//  Created by Emily Chang on 4/22/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

protocol GameProtocol{
    
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var incubator_view: UIView!
    

    @IBOutlet weak var garden_view: UIView!
    @IBOutlet weak var store_view: UIView!
    
    @IBOutlet weak var current_plant: UIImageView!
    @IBOutlet weak var plant_age: UILabel!
    
    var allPlants = Array<Plant>()
    var indexOfPlant: Int  = 0
    
    @IBOutlet weak var maturity_bar: UIProgressView!

    @IBAction func switch_segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            garden_view.isHidden = true
            store_view.isHidden = true
        case 1:
            garden_view.isHidden = false
            store_view.isHidden = true
        case 2:
            garden_view.isHidden = true
            store_view.isHidden = false
        default:
            break
        }
    }
    
    
    @IBAction func next_button(_ sender: Any) {
        if(indexOfPlant < allPlants.count - 1 ){
            indexOfPlant += 1
            current_plant.image = UIImage( named: allPlants[indexOfPlant].third_stage)
            plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
            maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
        }
    }
    
    @IBAction func back_button(_ sender: Any) {
        if(indexOfPlant != 0){
            indexOfPlant -= 1
            current_plant.image = UIImage( named: allPlants[indexOfPlant].third_stage)
            plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
            maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allPlants.append(Rose)
        allPlants.append(Sunflower)
        allPlants.append(Lilac)
        allPlants.append(Cactus)
        
        allPlants[0].age = 2
        allPlants[1].age = 5
        allPlants[2].age = 8
        allPlants[3].age = 10
        
        current_plant.image = UIImage(named: allPlants[indexOfPlant].third_stage)
        plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
        
        maturity_bar.progressTintColor = .blue
        maturity_bar.transform = maturity_bar.transform.scaledBy(x: 1, y: 8)
        maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
    }

}

extension GameViewController : GameProtocol{
    
}
