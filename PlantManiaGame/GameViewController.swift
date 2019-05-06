//
//  GameViewController.swift
//  PlantManiaGame
//
//  Created by Emily Chang on 4/22/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import AVFoundation

protocol GameProtocol{
    
}

class GameViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var allPlants = Array<Plant>()
    var indexOfPlant: Int = 0
    var gardenPlants = Array<Plant>()
    var fullyGrown = false
    var wallet: Int = 0
    var ageArray = Array<Int>()
    var waterArray = Array<Int>()
    var audioPlayer = AVAudioPlayer()
    
   
    @IBOutlet weak var incubator_view: UIView!
    
    @IBOutlet weak var current_plant: UIImageView!
    @IBOutlet weak var plant_name: UILabel!
    @IBOutlet weak var plant_age: UILabel!
    @IBOutlet weak var maturity_bar: UIProgressView!
    @IBOutlet weak var add_garden: UIButton!
    @IBOutlet weak var sell_plant: UIButton!
    @IBOutlet weak var time_away: UILabel!
    @IBOutlet weak var water_bar: UIProgressView!
    
    //next plant in array
    @IBAction func next_button(_ sender: Any) {
        if(indexOfPlant < allPlants.count - 1 ){
            indexOfPlant += 1

            if(allPlants.count == 0){
                emptyIncubator()
            }
            else{
                displayPlantInfo(myPlant: allPlants[indexOfPlant])
            }
            //defaults.set(indexOfPlant, forKey: "myIndex")
        }
    }
    
    //previous plant in array
    @IBAction func back_button(_ sender: Any) {
        if(indexOfPlant != 0){
            indexOfPlant -= 1

            if(allPlants.count == 0){
                emptyIncubator()
            }
            else{
                displayPlantInfo(myPlant: allPlants[indexOfPlant])
            }
            //defaults.set(indexOfPlant, forKey: "myIndex")
        }
    }
    
    //click to water plant
    @IBAction func water_plant(_ sender: Any) {
        if(allPlants[indexOfPlant].current_water + 5 > 10){
            allPlants[indexOfPlant].current_water = 10
        }
        else{
            allPlants[indexOfPlant].current_water += 5
        }
        displayPlantInfo(myPlant: allPlants[indexOfPlant])
        
        let encodedAllPlants: Data = NSKeyedArchiver.archivedData(withRootObject: allPlants)
        defaults.set(encodedAllPlants, forKey: "defaultAllPlants")
        defaults.synchronize()
        
    }
    
    //adds a fully mature plant to garden
    @IBAction func add_garden(_ sender: Any) {
        let addGardenPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID")as! IncubatorPopUpViewController
        self.addChild(addGardenPopUpVC)
        addGardenPopUpVC.view.frame = self.view.frame
        addGardenPopUpVC.alertLable.text = "Successfully added plant to garden!"
        self.view.addSubview(addGardenPopUpVC.view)
        addGardenPopUpVC.didMove(toParent: self)
        
        //adds to the garden plant array
        gardenPlants.append(allPlants[indexOfPlant])
        
        allPlants.remove(at: indexOfPlant)
        if (indexOfPlant > (allPlants.count - 1)){
            indexOfPlant = (allPlants.count - 1)
        }
        
        if(allPlants.count == 0){
            emptyIncubator()
        }
        else{
            displayPlantInfo(myPlant: allPlants[indexOfPlant])
        }
        
        //defaults.set(indexOfPlant, forKey: "myIndex")
        
        //remove from ageArray
//        ageArray.remove(at: indexOfPlant)
//        defaults.set(ageArray, forKey: "ageArray")
        
        //update the user default all plants array
        let encodedAllPlants: Data = NSKeyedArchiver.archivedData(withRootObject: allPlants)
        defaults.set(encodedAllPlants, forKey: "defaultAllPlants")
        defaults.synchronize()
        
        //update the user default garden plants array
        let encodedGardenPlants: Data = NSKeyedArchiver.archivedData(withRootObject: gardenPlants)
        defaults.set(encodedGardenPlants, forKey: "defaultGardenPlants")
        defaults.synchronize()
        
    }
    @IBAction func sell_plant(_ sender: Any) {
        let addGardenPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID")as! IncubatorPopUpViewController
        self.addChild(addGardenPopUpVC)
        addGardenPopUpVC.view.frame = self.view.frame
        addGardenPopUpVC.alertLable.text = "Successfully sold plant! You earned " + String(allPlants[indexOfPlant].price) + " coins"
        self.view.addSubview(addGardenPopUpVC.view)
        addGardenPopUpVC.didMove(toParent: self)
        
        wallet += allPlants[indexOfPlant].price
        
        allPlants.remove(at: indexOfPlant)
        if (indexOfPlant > (allPlants.count - 1)){
            indexOfPlant = (allPlants.count - 1)
        }
        
        if(allPlants.count == 0){
            emptyIncubator()
        }
        else{
            displayPlantInfo(myPlant: allPlants[indexOfPlant])
        }
        
        //remove from ageArray
//        ageArray.remove(at: indexOfPlant)
//        defaults.set(ageArray, forKey: "ageArray")
        
        //defaults.set(indexOfPlant, forKey: "myIndex")
        defaults.set(wallet, forKey: "myWallet")
        
        //update the user default all plants array
        let encodedAllPlants: Data = NSKeyedArchiver.archivedData(withRootObject: allPlants)
        defaults.set(encodedAllPlants, forKey: "defaultAllPlants")
        defaults.synchronize()
        
    }
    
    func displayPlantInfo(myPlant: Plant){
        
        //displays image and age of first plant upon loading app
        self.current_plant.image = currentStage(myPlant: myPlant)
        self.plant_name.text = myPlant.plant_name
        self.plant_age.text = String(myPlant.age) + " Days Old"
        self.maturity_bar.progressTintColor = .blue
        self.maturity_bar.progress = Float(myPlant.age) * 0.1
        self.water_bar.progressTintColor = .blue
        self.water_bar.progress = Float(myPlant.current_water) * 0.1
        
        //checks if fully grown
        fullyGrown = checkFullyGrown(myPlant: allPlants[indexOfPlant])
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
    
    func emptyIncubator(){
        self.current_plant.image = nil
        self.plant_name.text = "No plant in Incubator!"
        self.plant_age.text = nil
        self.maturity_bar.progressTintColor = .blue
        self.maturity_bar.progress = 0
        self.water_bar.progress = 0
        add_garden.isHidden = true
        sell_plant.isHidden = true
    }
    
    //function to hide and unhide add_garden button
    func checkFullyGrown(myPlant: Plant) -> Bool{
        if (myPlant.age! >= 10){
            add_garden.isHidden = false
            sell_plant.isHidden = false
            return true
        }
        add_garden.isHidden = true
        sell_plant.isHidden = true
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = Bundle.main.path(forResource: "Cheerful-Garden", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
        catch {
            print(error)
        }
        
        //load default values
        if let decodedIncubator  = defaults.data(forKey: "defaultAllPlants"){
            let decodedIncubatorPlants = NSKeyedUnarchiver.unarchiveObject(with: decodedIncubator) as! [Plant]
            self.allPlants = decodedIncubatorPlants
            print("Loading plants")
            //print(allPlants.count)
            //print(allPlants[0].age)
        }

        if let decodedGarden  = defaults.data(forKey: "defaultGardenPlants"){
            let decodedGardenPlants = NSKeyedUnarchiver.unarchiveObject(with: decodedGarden) as! [Plant]
            self.gardenPlants = decodedGardenPlants
        }
        //self.indexOfPlant = defaults.integer(forKey: "myIndex")
        self.wallet = defaults.integer(forKey: "myWallet")
        //self.ageArray = defaults.object(forKey: "ageArray") as? [Int] ?? [Int]()
        //wallet = 50
        //hardcoded test plants
//        allPlants.removeAll()
//        gardenPlants.removeAll()

       allPlants.append(Rose())
//        allPlants.append(Rose())
//        allPlants.append(Rose())
        allPlants.append(Sunflower())
//        allPlants.append(Lilac())
//        allPlants.append(Cactus())
//        allPlants.append(Rose())
//        allPlants.append(Cactus())
//
//
        allPlants[0].age = 10
        allPlants[1].age = 10
//       allPlants[2].age = 10
        //allPlants[0].current_water = 10

     
        
        //calculates time away and ages plants
        if let date2 = defaults.object(forKey: "date") as? Date {
            let seconds = Date().timeIntervalSince(date2)
            let minutes = Int(seconds)/15
            time_away.text = "Time away: " + String(Int(minutes)) + " days"
            
            for plant in allPlants{
                plant.age += Int(minutes)
                if (plant.current_water - Int(minutes) < 0){
                    plant.current_water = 0
                }
                else{
                    plant.current_water -= Int(minutes)
                }
            }
            
        }
        
        let date = Date()
        defaults.set(date, forKey: "date")
        
        let encodedAllPlants: Data = NSKeyedArchiver.archivedData(withRootObject: allPlants)
        defaults.set(encodedAllPlants, forKey: "defaultAllPlants")
        defaults.synchronize()
        
        maturity_bar.transform = maturity_bar.transform.scaledBy(x: 1, y: 8)
        
        water_bar.transform = CGAffineTransform(rotationAngle: .pi / -2)
        water_bar.transform = water_bar.transform.scaledBy(x: 1, y: 8)
        
        if(allPlants.count == 0){
            emptyIncubator()
        }
        else{
            displayPlantInfo(myPlant: allPlants[indexOfPlant])
        }
    }
    
    //segue to new Garden VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "storeSegue" {
            let controller = segue.destination as! StoreViewController
            controller.walletInt = self.wallet
        } else if segue.identifier == "gardenSegue" {
            let controller = segue.destination as! GardenViewController
            controller.garden_plants = self.gardenPlants
        }
        

    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
        let encodedAllPlants: Data = NSKeyedArchiver.archivedData(withRootObject: allPlants)
        defaults.set(encodedAllPlants, forKey: "defaultAllPlants")
        defaults.synchronize()
        
        if(allPlants.count != 0){
            indexOfPlant = 0
            displayPlantInfo(myPlant: allPlants[indexOfPlant])
        }
        else{
            emptyIncubator()
        }
    }

}

extension GameViewController : GameProtocol{
    
}
