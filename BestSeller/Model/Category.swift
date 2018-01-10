//
//  Category.swift
//  BestSeller
//
//  Created by erick manrique on 1/9/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import Foundation


class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
    }
    
}

class Category: SafeJsonObject, NSCoding {
    
    @objc var display_name: String?
    @objc var list_name: String?
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    // MARK:- NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(display_name, forKey: "display_name")
        aCoder.encode(list_name, forKey: "list_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.display_name = aDecoder.decodeObject(forKey: "display_name") as? String
        self.list_name = aDecoder.decodeObject(forKey: "list_name") as? String
    }
    
}

