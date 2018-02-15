//
//  VMTest.swift
//  AGLTestTests
//
//  Created by Soan Saini on 15/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import XCTest

class VMTest: XCTestCase {
    
    let DummyJson = [["name":"Bob","gender":"Male","age":23,"pets":[["name":"Garfield","type":"Cat"],["name":"Fido","type":"Dog"]]],["name":"Jennifer","gender":"Female","age":18,"pets":[["name":"Garfield","type":"Cat"]]],["name":"Fred","gender":"Male","age":40,"pets":[["name":"Tom","type":"Cat"],["name":"Max","type":"Cat"],["name":"Sam","type":"Dog"],["name":"Jim","type":"Cat"]]],["name":"Samantha","gender":"Female","age":40,"pets":[["name":"Tabby","type":"Cat"]]],["name":"Alice","gender":"Female","age":64,"pets":[["name":"Simba","type":"Cat"],["name":"Nemo","type":"Fish"]]]]
    
    let modelInstance = PeopleViewModel()
    
    func testGroupedSorting() {
        //Given
        let peoplesArray = People.peopleList(from: DummyJson)
        //When
        let groupedSortedData = modelInstance.GroupAndSortData(data:peoplesArray )
        //Then
        //Both females and males should only contain cats
        for key in groupedSortedData.keys {
            let sortedCats = groupedSortedData[key]
            XCTAssert(!(sortedCats?.contains(where: {$0.petType == PetType.dog}))!, "Array Contains Dog")
            XCTAssert(!(sortedCats?.contains(where: {$0.petType == PetType.fish}))!, "Array Contains Fish")
            XCTAssert(!(sortedCats?.contains(where: {$0.petType == PetType.unknown}))!, "Array Contains Unknwon")
        }
    }
    
}
