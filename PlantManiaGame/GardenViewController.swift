//
//  GardenViewController.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/25/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

<<<<<<< HEAD
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
    
    
=======
class GardenViewController: UIViewController {

>>>>>>> 45f37edcf4fdcdd80446528682f66381c522c9fe
    var garden_plants = Array<Plant>()
    var current_index = 0
    
<<<<<<< HEAD
    //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    

=======
   
    @IBAction func next_plants(_ sender: Any) {
        if(current_index < garden_plants.count - 1 ){
            current_index += 1
            plant_name.text = garden_plants[current_index].plant_name
            plant_image.image = UIImage( named: garden_plants[current_index].third_stage)
            plant_number.text = "Plant Number " + String(current_index+1)
        }
    }
    
    @IBAction func previous_plants(_ sender: Any) {
        if(current_index != 0){
            current_index -= 1
            plant_name.text = garden_plants[current_index].plant_name
            plant_image.image = UIImage( named: garden_plants[current_index].third_stage)
            plant_number.text = "Plant Number " + String(current_index+1)
        }
    }
>>>>>>> 45f37edcf4fdcdd80446528682f66381c522c9fe
    
    @IBAction func takePhoto(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        
        //Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
=======
        if(garden_plants.count == 0){
            plant_name.text = "No plants in garden!"
            plant_number.text = "Go add more plants!"
        }
        else{
            plant_name.text = garden_plants[0].plant_name
            plant_image.image = UIImage(named: garden_plants[0].third_stage)
            plant_number.text = "Plant Number " + String(current_index+1)
        }
>>>>>>> 45f37edcf4fdcdd80446528682f66381c522c9fe
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
