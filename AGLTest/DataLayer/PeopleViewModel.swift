//
//  PeopleFeedManager.swift
//  AGLTest
//
//  Created by Soan Saini on 13/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

class PeopleViewModel{
    let dataApi = PeopleFeedAPI()

    init() {
    }
    
    func FetchPeopleFeed(completionHandler: @escaping (Result<[GenderType: [Pet]]>) -> Void) {
        dataApi.FetchFeed { (result) in
            switch result
            {
            case .response(let data):
                completionHandler(Result.response(self.GroupAndSortData(data: data)))
                break
            case .error(error: let errorReceived):
                completionHandler(Result.error(error: errorReceived))
                break
            }
        }
    }
    
    func GroupAndSortData(data: [People]) -> [GenderType: [Pet]] {
        let grouped = Dictionary(grouping:data.filter({$0.pets.contains(where: {$0.petType == PetType.cat})}), by:{$0.gender})
        return grouped.mapValues { $0.flatMap({$0.pets.flatMap({$0})}).filter({$0.petType == PetType.cat}).sorted(by: {$0.name < $1.name})}
    }
}
