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
    
    let defaults = UserDefaults.standard
    var allPlants = Array<Plant>()
    var indexOfPlant: Int = 0
    var gardenPlants = Array<Plant>()
    var fullyGrown = false
    
   
    @IBOutlet weak var incubator_view: UIView!
    
    @IBOutlet weak var current_plant: UIImageView!
    @IBOutlet weak var plant_name: UILabel!
    @IBOutlet weak var plant_age: UILabel!
    @IBOutlet weak var maturity_bar: UIProgressView!
    @IBOutlet weak var add_garden: UIButton!
    @IBOutlet weak var time_away: UILabel!
    
    //next plant in array
    @IBAction func next_button(_ sender: Any) {
        if(indexOfPlant < allPlants.count - 1 ){
            indexOfPlant += 1
            current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
            plant_name.text = allPlants[indexOfPlant].plant_name
            plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
            maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
            
            //checks if plant is fully grown
            fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
            //defaults.set(indexOfPlant, forKey: "myIndex")
        }
    }
    
    //previous plant in array
    @IBAction func back_button(_ sender: Any) {
        if(indexOfPlant != 0){
            indexOfPlant -= 1
            current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
            plant_name.text = allPlants[indexOfPlant].plant_name
            plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
            maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
            
            //checks if plant is fully grown
            fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
            //defaults.set(indexOfPlant, forKey: "myIndex")
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
        
        allPlants.remove(at: indexOfPlant)
        if (indexOfPlant > (allPlants.count - 1)){
            indexOfPlant = (allPlants.count - 1)
        }
        current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
        plant_name.text = allPlants[indexOfPlant].plant_name
        plant_age.text = String(allPlants[indexOfPlant].age) + " Days Old"
        maturity_bar.progress = Float(allPlants[indexOfPlant].age) * 0.1
        
        //checks if plant is fully grown
        fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
        defaults.set(indexOfPlant, forKey: "myIndex")

        
//        let encodedGardenPlants: Data = NSKeyedArchiver.archivedData(withRootObject: gardenPlants)
//        defaults.set(encodedGardenPlants, forKey: "defaultGardenPlants")
//        defaults.synchronize()
        
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
        if (myPlant.age! >= 10){
            add_garden.isHidden = false
            return true
        }
        add_garden.isHidden = true
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load default values
        
        //let decodedGarden  = defaults.data(forKey: "defaultGardenPlants")
        //let decodedGardenPlants = NSKeyedUnarchiver.unarchiveObject(with: decodedGarden!) as! [Plant]
        //self.gardenPlants = decodedGardenPlants
        //self.indexOfPlant = defaults.integer(forKey: "myIndex")
        
        //hardcoded test plants
        allPlants.append(Rose())
        allPlants.append(Sunflower())
        allPlants.append(Lilac())
        allPlants.append(Cactus())
        allPlants.append(Rose())
        allPlants.append(Lilac())
        allPlants.append(Sunflower())
        
        allPlants[0].age = 9
        allPlants[1].age = 9
        allPlants[4].age = 3
        allPlants[5].age = 5
        allPlants[6].age = 10
        
        //calculates time away and ages plants
        if let date2 = defaults.object(forKey: "date") as? Date {
            let seconds = Date().timeIntervalSince(date2)
            let minutes = Int(seconds)/60
            time_away.text = "Time away: " + String(minutes) + " days"
            
            for plant in allPlants{
                plant.age += minutes
            }
        }
        
        let date = Date()
        defaults.set(date, forKey: "date")
     
        
        //displays image and age of first plant upon loading app
        current_plant.image = currentStage(myPlant: allPlants[indexOfPlant])
        plant_name.text = allPlants[indexOfPlant].plant_name
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
