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
    
    //var allPlants = GlobalVariables.allPlants
    var allPlants = Array<Plant>()
    var indexOfPlant: Int  = 0
    var gardenPlants = Array<Plant>()
    var fullyGrown = false
    
   
    @IBOutlet weak var incubator_view: UIView!
//    @IBOutlet weak var garden_view: UIView!
//    @IBOutlet weak var store_view: UIView!
    
    @IBOutlet weak var current_plant: UIImageView!
    @IBOutlet weak var plant_age: UILabel!
    @IBOutlet weak var maturity_bar: UIProgressView!
    @IBOutlet weak var add_garden: UIButton!
    
    @IBAction func next_button(_ sender: Any) {
        if(indexOfPlant < allPlants.count - 1 ){
            indexOfPlant += 1
            current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
            plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
            maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
            
            //checks if plant is fully grown
            fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
        }
    }
    
    @IBAction func back_button(_ sender: Any) {
        if(indexOfPlant != 0){
            indexOfPlant -= 1
            current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
            plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
            maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
            
            //checks if plant is fully grown
            fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
        }
    }
    
    //adds a fully mature plant to garden
    @IBAction func add_garden(_ sender: Any) {
        let addGardenPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID")as! IncubatorPopUpViewController
        self.addChild(addGardenPopUpVC)
        addGardenPopUpVC.view.frame = self.view.frame
        self.view.addSubview(addGardenPopUpVC.view)
        addGardenPopUpVC.didMove(toParent: self)
        
        //adds to the garden plant array
        gardenPlants.append(allPlants[indexOfPlant])
        
    }
    
    //displays current stage of plant
    func currentStage(myPlant: Plant) -> UIImage{
        let age = myPlant.age
        if (age! < 3){
            return UIImage(named: myPlant.first_stage)!
        }
        if (age! >= 3 && age! < 8){
            return UIImage(named: myPlant.second_stage)!
        }
        if (age! >= 8){
            return UIImage(named: myPlant.third_stage)!
        }
        
        return UIImage(named: "sunflower-seed-clipart-1")!
    }
    
    //function to hide and unhide add_garden button
    func checkFullyGrown(myPlant: Plant) -> Bool{
        if (myPlant.age! == 10){
            add_garden.isHidden = false
            return true
        }
        add_garden.isHidden = true
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hardcoded test plants
        allPlants.append(Rose())
        allPlants.append(Sunflower())
        allPlants.append(Lilac())
        allPlants.append(Cactus())
        allPlants.append(Rose())
        allPlants.append(Lilac())
        allPlants.append(Sunflower())

        allPlants[0].age = 2
        allPlants[1].age = 5
        allPlants[2].age = 8
        
        //displays image and age of first plant upon loading app
        current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
        plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
        maturity_bar.progressTintColor = .blue
        maturity_bar.transform = maturity_bar.transform.scaledBy(x: 1, y: 8)
        maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
        
        //checks if plant is fully grown
        fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
    }
    
    //segue to new VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gardenViewController = segue.destination as? GardenViewController
            else {
                return
            }
        gardenViewController.garden_plants = gardenPlants
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}

}

extension GameViewController : GameProtocol{
    
}
