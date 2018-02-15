//
//  AGLTestTests.swift
//  AGLTestTests
//
//  Created by Soan Saini on 13/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import XCTest
@testable import AGLTest

class AGLTestJsonTests: XCTestCase {
    
    static let DummyJson = [["name":"Bob","gender":"Male","age":23,"pets":[["name":"Garfield","type":"Cat"],["name":"Fido","type":"Dog"]]],["name":"Jennifer","gender":"Female","age":18,"pets":[["name":"Garfield","type":"Cat"]]],["name":"Fred","gender":"Male","age":40,"pets":[["name":"Tom","type":"Cat"],["name":"Max","type":"Cat"],["name":"Sam","type":"Dog"],["name":"Jim","type":"Cat"]]],["name":"Samantha","gender":"Female","age":40,"pets":[["name":"Tabby","type":"Cat"]]],["name":"Alice","gender":"Female","age":64,"pets":[["name":"Simba","type":"Cat"],["name":"Nemo","type":"Fish"]]]]
    
    func testPetJson() {
        //Given
        let JsonObject: [String: String] = ["name":"Jim", "type": "Cat"]
        //When
        let pet = Pet(jsonDict: JsonObject)
        //Then
        XCTAssert(pet.name == "Jim", "Not Parsed Properly")
        XCTAssert(pet.petType == PetType.cat, "Not Parsed Properly")
    }
    
    func testPeopleJson() {
        let people = People(jsonDict: AGLTestJsonTests.DummyJson.first!)
        XCTAssert(people.name == "Bob", "Not Parsed Properly")
        XCTAssert(people.gender == GenderType.male, "Not Parsed Properly")
        XCTAssert(people.age == 23, "Not Parsed Properly")
        XCTAssert(people.pets.count == 2, "Not Parsed Properly")
    }
    
    let feed = PeopleFeedAPI()
    
    func testJsonParsing() {
        let data: [People] = feed.Feed(jsonData: AGLTestJsonTests.DummyJson)
        XCTAssert(data.first?.age == 23, "Error in Parsing JSON")
    }
}
