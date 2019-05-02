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
    var seed: String!
    var first_stage: String!
    var second_stage: String!
    var third_stage: String!
    var age: Int!
    
    init(){
        
    }
    
//    init(plant_name: String, max_water: Int, current_water: Int, seed: String, first_stage: String, second_stage: String, third_stage: String, age: Int){
//
//        self.plant_name = plant_name
//        self.max_water = max_water
//        self.current_water = current_water
//        self.seed = seed
//        self.first_stage = first_stage
//        self.second_stage = second_stage
//        self.third_stage = third_stage
//        self.age = age
//    }
    
}

class Cactus: Plant{
    override init(){
        super.init()
        
        self.plant_name = "Cactus"
        self.max_water = 10
        self.current_water = 10
        self.seed = "sunflower-seed-clipart-1"
        self.first_stage = "pot"
        self.second_stage = "sprout"
        self.third_stage = "cactus"
        self.age = 10
    }
}

class Sunflower: Plant{
    override init(){
        super.init()
        
        self.plant_name = "Sunflower"
        self.max_water = 10
        self.current_water = 10
        self.seed = "sunflower-seed-clipart-1"
        self.first_stage = "pot"
        self.second_stage = "sprout"
        self.third_stage = "sunflower"
        self.age = 10
    }
}

class Lilac: Plant{
    override init(){
        super.init()
        
        self.plant_name = "Lilac"
        self.max_water = 10
        self.current_water = 10
        self.seed = "sunflower-seed-clipart-1"
        self.first_stage = "pot"
        self.second_stage = "sprout"
        self.third_stage = "lilac"
        self.age = 10
    }
}

class Rose: Plant{
    override init(){
        super.init()
        
        self.plant_name = "Rose"
        self.max_water = 10
        self.current_water = 10
        self.seed = "sunflower-seed-clipart-1"
        self.first_stage = "pot"
        self.second_stage = "sprout"
        self.third_stage = "rose"
        self.age = 10
    }
}

//let Cactus = Plant(plant_name: "Cactus", max_water: 10, current_water: 10, seed: "sunflower-seed-clipart-1", first_stage: "pot", second_stage: "sprout", third_stage: "cactus", age: 10)
//
//let Sunflower = Plant(plant_name: "Sunflower", max_water: 10, current_water: 10, seed: "sunflower-seed-clipart-1", first_stage: "pot", second_stage: "sprout", third_stage: "sunflower", age: 10)
//
//let Lilac = Plant(plant_name: "Lilac", max_water: 10, current_water: 10, seed: "sunflower-seed-clipart-1", first_stage: "pot", second_stage: "sprout", third_stage: "lilac", age: 10)
//
//let Rose = Plant(plant_name: "Rose", max_water: 10, current_water: 10, seed: "sunflower-seed-clipart-1", first_stage: "pot", second_stage: "sprout", third_stage: "rose", age: 10)

//struct GlobalVariables {
//    static var allPlants = Array<Plant>()
//}
