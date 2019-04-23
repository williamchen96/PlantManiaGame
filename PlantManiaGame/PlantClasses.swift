//
//  PlantClasses.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//
import UIKit

class Plant {
    var plant_name: String!
    var max_water: Int!
    var current_water: Int!
    var first_stage: String!
    var second_stage: String!
    var third_stage: String!
    var age: Int!
    
    init(plant_name: String, max_water: Int, current_water: Int, first_stage: String, second_stage: String, third_stage: String, age: Int){
        
        self.plant_name = plant_name
        self.max_water = max_water
        self.current_water = current_water
        self.first_stage = first_stage
        self.second_stage = second_stage
        self.third_stage = third_stage
        self.age = age
    }
    
}

let Cactus = Plant(plant_name: "Cactus", max_water: 10, current_water: 10, first_stage: "pot", second_stage: "plant1", third_stage: "plant3", age: 0)

let Sunflower = Plant(plant_name: "Sunflower", max_water: 10, current_water: 10, first_stage: "pot", second_stage: "plant1", third_stage: "plant3", age: 0)
