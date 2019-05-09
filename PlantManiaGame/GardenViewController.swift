//
//  GardenViewController.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/25/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class GardenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var wallet = 0
    
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
    
    
    var garden_plants = Array<Plant>()
    var current_index = 0
    
    //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
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
        }
        
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
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
