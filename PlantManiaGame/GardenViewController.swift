//
//  GardenViewController.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/25/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class GardenViewController: UIViewController {

    var garden_plants = Array<Plant>()
    var current_index = 0
    var wallet: Int = 0

    @IBOutlet weak var plant_name: UILabel!
    @IBOutlet weak var plant_image: UIImageView!
    @IBOutlet weak var plant_number: UILabel!
    
   
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
    
    @IBAction func takePhoto(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(garden_plants.count == 0){
            plant_name.text = "No plants in garden!"
            plant_number.text = "Go add more plants!"
        }
        else{
            plant_name.text = garden_plants[0].plant_name
            plant_image.image = UIImage(named: garden_plants[0].third_stage)
            plant_number.text = "Plant Number " + String(current_index+1)
        }
        // Do any additional setup after loading the view.
    }
    
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
