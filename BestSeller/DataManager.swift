//
//  DataManager.swift
//  BestSeller
//
//  Created by erick manrique on 1/10/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()

    // MARK:- Save paths
    private var categoriesPath: String {
        return getDocumentsPath(using: "categoriesPath")
    }
    
    private var booksPath: String {
        return getDocumentsPath(using: "booksPath")
    }
    
    // MARK:- Save methods
    func saveCategories(categories: [Category]) {
        NSKeyedArchiver.archiveRootObject(categories, toFile: categoriesPath)
    }
    
    func saveBooks(books: [Book]) {
        NSKeyedArchiver.archiveRootObject(books, toFile: booksPath)
    }
    
    // MARK:- Retrieve methods
    func retrieveCategories() -> [Category]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: categoriesPath) as? [Category]
    }
    
    func retrieveBooks() -> [Book]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: booksPath) as? [Book]
    }
    
    private func getDocumentsPath(using pathComponent:String) -> String {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let urlPath = documentsPath.appendingPathComponent(pathComponent)
        return urlPath.path
    }
}
