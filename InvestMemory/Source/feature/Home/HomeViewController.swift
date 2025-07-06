//
//  HomeView.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController {
    
    var homeContentView: UIView!
    var searchViewController: SearchViewController!
    var bottomTabBarController: BottomTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad() // BaseViewController의 setupUI()와 makeConstraints() 호출됨
        setupSearchViewController()
        setupBottomTabBar()
        setupHomeContent()
    }
    
    func setupSearchViewController() {
        searchViewController = SearchViewController()
        addChild(searchViewController)
        searchBox.addSubview(searchViewController.view)
        searchViewController.didMove(toParent: self)
        
        searchViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBottomTabBar() {
        bottomTabBarController = BottomTabBar()
        addChild(bottomTabBarController)
        bottomTabBar.addSubview(bottomTabBarController.view)
        bottomTabBarController.didMove(toParent: self)
        
        bottomTabBarController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupHomeContent() {
        homeContentView = UIView().then {
            $0.backgroundColor = .lightGray // 확인용 색상
        }
        
        fullView.addSubview(homeContentView)
        
        homeContentView.snp.makeConstraints { make in
            make.top.equalTo(searchBox.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomTabBar.snp.top)
        }
    }
}
