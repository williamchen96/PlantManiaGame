//
//  StoreViewController.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/25/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import AVFoundation

class StoreViewController: UIViewController {
    
    var allSeeds = Array<Plant>()
    var indexOfSeed: Int = 0
    var incubatorPlants = Array<Plant>()
    var walletInt: Int = 0
    var popupText: String = ""
    let defaults = UserDefaults.standard
    var audio = AVAudioPlayer()
    
    @IBOutlet weak var walletAmount: UILabel!
    @IBOutlet weak var seed_name: UILabel!
    @IBOutlet weak var seed_price: UILabel!
    
 
    @IBOutlet weak var seed_image: UIImageView!
    
    
    @IBAction func nextSeedButton(_ sender: Any) {
        if(indexOfSeed < allSeeds.count - 1 ){
            indexOfSeed += 1
            displaySeed()
        }
    }
    
    @IBAction func previousSeedButton(_ sender: Any) {
        if(indexOfSeed != 0){
            indexOfSeed -= 1
            displaySeed()
        }
    }
    
    
    @IBAction func BuyButton(_ sender: Any) {
        
        if (walletInt-allSeeds[indexOfSeed].price >= 0){
            incubatorPlants.append(allSeeds[indexOfSeed])
            walletInt-=allSeeds[indexOfSeed].price
            walletAmount.text = String (walletInt)
            let cashSound = Bundle.main.path(forResource: "Chaching", ofType: "mp3")
            do {
                audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: cashSound!))
            } catch {
                print(error)
            }
            audio.play()
            popupText = "New " + allSeeds[indexOfSeed].plant_name + " seed purchased!"
            
        }
        
        else{
            popupText = "Not enough coins!"
        }
        
        let addGardenPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID")as! IncubatorPopUpViewController
        self.addChild(addGardenPopUpVC)
        addGardenPopUpVC.view.frame = self.view.frame
        addGardenPopUpVC.alertLable.text = popupText
        self.view.addSubview(addGardenPopUpVC.view)
        addGardenPopUpVC.didMove(toParent: self)
        
        defaults.set(walletInt, forKey: "myWallet")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameViewController = segue.destination as? GameViewController
            else {
                return
        }
        for plant in incubatorPlants {
            gameViewController.allPlants.append(plant)
            incubatorPlants.removeFirst()
        }
        
        gameViewController.wallet = walletInt
    }
    
    func displaySeed(){
        seed_image.image = UIImage(named: allSeeds[indexOfSeed].seed)
        seed_name.text = allSeeds[indexOfSeed].plant_name
        seed_price.text = "Price: " + String(allSeeds[indexOfSeed].price)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSeeds.append(Rose())
        allSeeds.append(Sunflower())
        allSeeds.append(Lilac())
        allSeeds.append(Cactus())
        
        walletAmount.text = String (walletInt)
        displaySeed()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
