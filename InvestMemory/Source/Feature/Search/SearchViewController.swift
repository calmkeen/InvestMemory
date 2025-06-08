//
//  SearchViewController.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchText = UITextField()
    var searchButton = UISearchBar()
//    var recentPopularListView = UITableView {
//        var tb = UITableView()
//        return tb
//    }
//    var recentSearchingView = UITableView

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        searchText.placeholder = "This is search Viw"
        view.backgroundColor = .white
    }
    
}
