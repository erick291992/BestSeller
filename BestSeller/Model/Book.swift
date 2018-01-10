//
//  Book.swift
//  BestSeller
//
//  Created by erick manrique on 1/10/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import Foundation

class Book: SafeJsonObject, NSCoding {
    
    var book_details: BookDetails?
    @objc var amazon_product_url: String?
    @objc var list_name: String?
    @objc var rank: NSNumber?
    @objc var weeks_on_list: NSNumber?
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "book_details" {
            if let bookDetailsList = value as? [[String: Any]] {
                if bookDetailsList.count > 0 {
                    book_details = BookDetails(dictionary: bookDetailsList.first!)
                }
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(amazon_product_url, forKey: "amazon_product_url")
        aCoder.encode(list_name, forKey: "list_name")
        aCoder.encode(rank, forKey: "rank")
        aCoder.encode(weeks_on_list, forKey: "weeks_on_list")
        
//        aCoder.encodeRootObject(<#T##rootObject: Any##Any#>)
        aCoder.encode(book_details, forKey: "book_details")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.amazon_product_url = aDecoder.decodeObject(forKey: "amazon_product_url") as? String
        self.list_name = aDecoder.decodeObject(forKey: "list_name") as? String
        self.rank = aDecoder.decodeObject(forKey: "rank") as? NSNumber
        self.weeks_on_list = aDecoder.decodeObject(forKey: "weeks_on_list") as? NSNumber
        
        self.book_details = aDecoder.decodeObject(forKey: "book_details") as? BookDetails
    }
}

class BookDetails: SafeJsonObject, NSCoding {
    
    @objc var title: String?
    @objc var book_description: String?
    @objc var author: String?
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            book_description = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(book_description, forKey: "book_description")
        aCoder.encode(author, forKey: "author")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.book_description = aDecoder.decodeObject(forKey: "book_description") as? String
        self.author = aDecoder.decodeObject(forKey: "author") as? String
    }
    
}
