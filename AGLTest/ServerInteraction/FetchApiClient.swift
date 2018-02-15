//
//  PeopleFetch.swift
//  AGLTest
//
//  Created by Soan Saini on 13/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T>{
    case response(T)
    case error(error: Error)
}

protocol ServerInteraction {
    var endPoint: String {get}
}

class FetchApiClient<T> {
   private let serverDelegate: ServerInteraction

    init(delegate: ServerInteraction) {
        serverDelegate = delegate
    }
    
    public func FetchFeed( completionHandler: @escaping (Result<T>) -> Void) {
        let _ = Alamofire.request(serverDelegate.endPoint)
            .responseJSON { response in
                if let error = response.result.error {
                    completionHandler(Result.error(error: error))
                    return
                }
                guard let jsonData = response.result.value as? [[String: Any]] else
                {
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }

                let feedReceived = self.Feed(jsonData: jsonData)
                completionHandler(Result.response(feedReceived))
        }
    }
    
    public func Feed(jsonData: [[String: Any]]) -> T
    {
        fatalError("Must Override")
    }
}
