//
//  SearchViewController.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    var test = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        test.text = "This is search Viw"
        view.backgroundColor = .white
    }
}
