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
    
    //MARK: - In homeViewValue
    var userName: String = "Guest"
    var guideInfoLb: String = "님 \n 오늘은 어떤 투자를 해 볼까요?"
    
    override func viewDidLoad() {
        super.viewDidLoad() // BaseViewController의 setupUI()와 makeConstraints() 호출됨
        setupHomeContent()
        addViewSetup()
        setConstraints()
    }
    
    func addViewSetup() {
        searchViewController = SearchViewController()
        bottomTabBarController = BottomTabBar()
        
        fullView.addSubview(homeContentView)
        searchBox.addSubview(searchViewController.view)
        bottomTabBar.addSubview(bottomTabBarController.view)

        addChild(searchViewController)
        addChild(bottomTabBarController)
        
        searchViewController.didMove(toParent: self)
        bottomTabBarController.didMove(toParent: self)
    }
    
    func setConstraints() {
        homeContentView.snp.makeConstraints { make in
            make.top.equalTo(searchBox.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomTabBar.snp.top)
        }
        
        searchViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomTabBarController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupHomeContent() {
        homeContentView = UIView().then {
            $0.backgroundColor = .lightGray // 확인용 색상
        }
    }
}
