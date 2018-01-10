//
//  BooksViewController.swift
//  BestSeller
//
//  Created by erick manrique on 1/10/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellId = String(describing: BookTableViewCell.self)
    
    var category: String!
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        setupNavigationItems()
        requestBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationItems(){
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(BooksViewController.filterPressed(_:)))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func filterPressed(_ sender: UIBarButtonItem) {
        filterBooks()
    }
    
    func filterBooks(){
        let selectedFilter = UserDefaults.standard.integer(forKey: filterKey)
        
        if books?.isEmpty == false {
            if selectedFilter == FilterKeyValues.Rank.rawValue {
                books?.sort(by: { (book1, book2) -> Bool in
                    if let rank1 = book1.rank?.intValue, let rank2 = book2.rank?.intValue {
                        if rank1 > rank2 {
                            return true
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                })
                UserDefaults.standard.set(FilterKeyValues.WeeksOnList.rawValue, forKey: filterKey)
                title = "by Rank"
                tableView.reloadData()
            } else {
                books?.sort(by: { (book1, book2) -> Bool in
                    if let rank1 = book1.weeks_on_list?.intValue, let rank2 = book2.weeks_on_list?.intValue {
                        if rank1 > rank2 {
                            return true
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                })
                UserDefaults.standard.set(FilterKeyValues.Rank.rawValue, forKey: filterKey)
                title = "by weeks on best seller list"
                tableView.reloadData()
            }
        }
    }
    
    func requestBooks() {
        NetworkClient.shared.getBestSeller(for: category) { (books, err) in
            guard err == nil else{
                if let retrievedBooks = DataManager.shared.retrieveBooks() {
                    DispatchQueue.main.async { [weak self] in
                        self?.books = retrievedBooks
                        self?.filterBooks()
                        self?.tableView.reloadData()
                    }
                }
                return
            }
            
            if let books = books {
                DispatchQueue.main.async { [weak self] in
                    DataManager.shared.saveBooks(books: books)
                    self?.books = books
                    self?.filterBooks()
                    self?.tableView.reloadData()
                }
            }
        }
    }

}


extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! BookTableViewCell
        cell.titleLabel.text = books?[indexPath.item].book_details?.title
        cell.descriptionLabel.text = books?[indexPath.item].book_details?.book_description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let book = books?[indexPath.item] {
            let viewController = BookViewController()
            viewController.book = book
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}





