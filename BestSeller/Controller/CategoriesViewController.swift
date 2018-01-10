//
//  CategoriesViewController.swift
//  BestSeller
//
//  Created by erick manrique on 1/9/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellId = String(describing: CategoryTableViewCell.self)
    var categories: [Category]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Book Categories"
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        requestCategories()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension CategoriesViewController {
    
    func requestCategories(){
        NetworkClient.shared.getBookCategories { (categories, err) in

            guard err == nil else{
                if let retrievedCategories = DataManager.shared.retrieveCategories() {
                    DispatchQueue.main.async { [weak self] in
                        self?.categories = retrievedCategories
                        self?.tableView.reloadData()
                    }
                }
                return
            }
            
            if let categories = categories {
                DispatchQueue.main.async { [weak self] in
                    DataManager.shared.saveCategories(categories: categories)
                    self?.categories = categories
                    self?.tableView.reloadData()
                }
            }
        }
    }
}


extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CategoryTableViewCell
        cell.nameLabel.text = categories?[indexPath.item].display_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let category = categories?[indexPath.item].list_name {
            let viewController = BooksViewController()
            viewController.category = category
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}










