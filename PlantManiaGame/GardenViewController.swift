//
//  GardenViewController.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/25/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit


class GardenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var garden_plants = Array<Plant>()
    var current_index = 0
    var wallet = 0
    
    var roseCount = 0
    var lilacCount = 0
    var sunflowerCount = 0
    var cactusCount = 0
    var roseRevenue = 0
    var lilacRevenue = 0
    var sunflowerRevenue = 0
    var cactusRevenue = 0
    
    //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return garden_plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCollectionViewCell
        current_index += 1
        cell.imageView.image = UIImage(named: garden_plants[indexPath.row].third_stage)
        
        //cell.imageView.image = UIImage(named: "rose")
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        updatePlantInfo()

        // Do any additional setup after loading the view.
    }
    
    func updatePlantInfo() {
        roseCount = 0
        lilacCount = 0
        sunflowerCount = 0
        cactusCount = 0
        
        for plant in garden_plants {
            if plant.plant_name == "Rose" {
                roseCount += 1
            } else if plant.plant_name == "Cactus" {
                cactusCount += 1
            } else if plant.plant_name == "Sunflower" {
                sunflowerCount += 1
            } else if plant.plant_name == "Lilac" {
                lilacCount += 1
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plantGameSegue" {
            let controller = segue.destination as! PlantGameViewController
            controller.wallet = self.wallet
        } else if segue.identifier == "plantInfoSegue" {
            if let plantInfoVC = segue.destination as? PlantInfoViewController {
                //Some property on ChildVC that needs to be set
                plantInfoVC.rose_number = self.roseCount
                plantInfoVC.sunflower_number = self.sunflowerCount
                plantInfoVC.cactus_number = self.cactusCount
                plantInfoVC.lilac_number = self.lilacCount
                
                plantInfoVC.rose_rev = self.roseRevenue
                plantInfoVC.cactus_rev = self.cactusRevenue
                plantInfoVC.sunflower_rev = self.sunflowerRevenue
                plantInfoVC.lilac_rev = self.lilacRevenue
            }
        }
        
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
