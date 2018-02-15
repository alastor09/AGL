//
//  Pet.swift
//  AGLTest
//
//  Created by Soan Saini on 13/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

enum PetType : String {
    case dog, cat, fish, unknown
}

enum GenderType: String {
    case male, female, unknown
}

struct Pet {
    let name: String
    let petType: PetType
    
    init(jsonDict: [String: String]) {
        guard let name = jsonDict["name"], let type = jsonDict["type"]  else {
            fatalError("Fields Not Available")
        }
        self.name = name
        self.petType = PetType(rawValue: type.lowercased()) ?? .unknown
    }
}

struct People {
    let name: String
    let gender: GenderType
    let age: Int
    var pets: [Pet] = []

    init(jsonDict: [String: Any]) {
        
        guard let name = jsonDict["name"] as? String,
            let age = jsonDict["age"] as? Int,
            let gender = jsonDict["gender"] as? String  else {
                fatalError("Fields Not Available")
        }
        
        self.name = name
        self.age = age
        self.gender = GenderType(rawValue: gender.lowercased()) ?? .unknown
        
        if let pets = jsonDict["pets"] as? [[String: String]] {
            self.pets = pets.map({ Pet(jsonDict: $0) })
        }
    }
    
    static func peopleList(from jsonData: [[String: Any]]) -> [People] {
        var dataArray: [People] = []
        for data in jsonData {
            dataArray.append(People(jsonDict: data))
        }
        return dataArray
    }
}
