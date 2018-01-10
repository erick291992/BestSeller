//
//  NetworkClient+NewYorkTimesApi.swift
//  BestSeller
//
//  Created by erick manrique on 1/9/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import Foundation

extension NetworkClient {
    
    func getBookCategories(completion:@escaping(_ categories:[Category]?, _ error: Error?) -> Void) {
        
        let parameters: [String: Any] = [
            "api-key":"45bc0bdc171a47cc8b5bd3babb669dc7"
        ]

        _ = taskGetMethod("/lists/names.json", parameters: parameters, httpHeaderValues: nil) { (res, err) in
            guard err == nil else {
                completion(nil, err)
                return
            }
            
            self.accessResults(from: res, completion: { (results) in
                if let results = results {
                    let categories = results.map({return Category(dictionary: $0)})
                    completion(categories, err)
                }
            })
            
        }
        
    }
    
    func getBestSeller(for category: String, completion: @escaping (_ categories:[Book]?, _ error: Error?) -> Void) {
        let parameters: [String: Any] = [
            "api-key":"45bc0bdc171a47cc8b5bd3babb669dc7",
            "list": category
        ]
        
        _ = taskGetMethod("/lists.json", parameters: parameters, httpHeaderValues: nil) { (res, err) in
            guard err == nil else {
                completion(nil, err)
                return
            }
            
            self.accessResults(from: res, completion: { (results) in
                if let results = results {
                    let books = results.map({return Book(dictionary: $0)})
                    completion(books, err)
                }
            })
            
        }
    }
    
    func accessResults(from response: Any?, completion:(_ results:[[String: Any]]?) -> Void) {
        
        if let jsonDictionaries = response as? [String: Any], let results = jsonDictionaries["results"] as? [[String: Any]] {
            completion(results)
        } else {
            completion(nil)
        }

    }
}
