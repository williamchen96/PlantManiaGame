//
//  PlantClasses.swift
//  PlantManiaGame
//
//  Created by William Chen on 4/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//
import UIKit

class Plant: NSObject, NSCoding {
    var plant_name: String!
    var max_water: Int!
    var current_water: Int!
    var seed: String!
    var first_stage: String!
    var second_stage: String!
    var third_stage: String!
    var age: Int!
    var price: Int!
    
    override init(){
        
    }

    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder) {
     
        self.init()
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.plant_name, forKey: "plant_name")
        aCoder.encode(self.max_water, forKey: "max_water")
        aCoder.encode(self.current_water, forKey: "current_water")
        aCoder.encode(self.seed, forKey: "seed")
        aCoder.encode(self.first_stage, forKey: "first_stage")
        aCoder.encode(self.second_stage, forKey: "second_stage")
        aCoder.encode(self.third_stage, forKey: "third_stage")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(self.price, forKey: "price")
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
        self.age = 0
        self.price = 5
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
        self.age = 0
        self.price = 4
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
        self.age = 0
        self.price = 6
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
        self.age = 0
        self.price = 5
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
