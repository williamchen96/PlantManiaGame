//
//  PlantInfoViewController.swift
//  PlantManiaGame
//
//  Created by SiuMarina on 5/9/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//


import UIKit

class PlantInfoViewController: UIViewController {
    //rose
    @IBOutlet weak var rose_image: UIImageView!
    @IBOutlet weak var rose_number_grown: UILabel!
    @IBOutlet weak var rose_total_earning: UILabel!
    var rose_number: Int!
    var rose_rev: Int!
    //lilac
    @IBOutlet weak var lilac_image: UIImageView!
    @IBOutlet weak var lilac_number_grown: UILabel!
    @IBOutlet weak var lilac_total_earning: UILabel!
    var lilac_number: Int!
    var lilac_rev: Int!
    //sunflower
    @IBOutlet weak var sunflower_image: UIImageView!
    @IBOutlet weak var sunflower_number_grown: UILabel!
    @IBOutlet weak var sunflower_total_earning: UILabel!
    var sunflower_number: Int!
    var sunflower_rev: Int!
    //cactus
    @IBOutlet weak var cactus_image: UIImageView!
    @IBOutlet weak var cactus_number_grown: UILabel!
    @IBOutlet weak var cactus_total_earning: UILabel!
    var cactus_number: Int!
    var cactus_rev: Int!
    
    
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToGarden", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rose_number_grown.text = String(rose_number)
        rose_image.image = UIImage(named: "rose")
        rose_total_earning.text = String(rose_rev)
        
        sunflower_number_grown.text = String(sunflower_number)
        sunflower_image.image = UIImage(named: "sunflower")
        sunflower_total_earning.text = String(sunflower_rev)
        
        lilac_number_grown.text = String(lilac_number)
        lilac_image.image = UIImage(named: "lilac")
        lilac_total_earning.text = String(lilac_rev)
        
        cactus_number_grown.text = String(cactus_number)
        cactus_image.image = UIImage(named: "cactus")
        cactus_total_earning.text = String(cactus_rev)
        
        
    }
    
}

