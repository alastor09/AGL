//
//  PeopleFeed.swift
//  AGLTest
//
//  Created by Soan Saini on 13/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

class PeopleFeedAPI: FetchApiClient<[People]>, ServerInteraction {
    internal let endPoint: String =  "http://agl-developer-test.azurewebsites.net/people.json"
    
    init() {
        super.init(delegate: self)
    }
    
    override func Feed(jsonData: [[String: Any]]) -> [People] {
        var dataArray: [People] = []
        for data in jsonData {
            dataArray.append(People(jsonDict: data))
        }
        return dataArray
    }
}
