//
//  HomeView.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {
    
    var HomeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    var navigationView: UIView = {
        let navi = UIView()
        navi.backgroundColor = .lightGray
        return navi
    }()
    var searchBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    var searchButton: UIButton = {
        let btn = UIButton()
        btn.sizeToFit()
        return btn
    }()
    
    var sliderNews: UIView!
    
    var todayAcountInfoView: UIView!
    var todayAccountInfoCard: UIView!
    
    var typeBoxView:UIView!
    var typeBoxVstack: UIStackView!
    var typeboxHstack: UIStackView!
    
    var investGuideView: UIView!
    var bottomSelectView: UIView!
    
    
    
    override func viewDidLoad() {
        addCompnent()
        addConstraints()
        setupValue()
        homeSetupAction()
    }
    
    func setupValue() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
    }
    
    func addCompnent() {
        view.addSubview(HomeView)
        HomeView.addSubview(navigationView, searchBoxView,searchButton)
//        HomeView.addSubview(sliderNews)
//        HomeView.addSubview(todayAcountInfoView, todayAccountInfoCard)
//        HomeView.addSubview(typeBoxView, typeboxHstack, typeBoxVstack)
//        HomeView.addSubview(investGuideView)
//        HomeView.addSubview(bottomSelectView)
        
    }
    
    func addConstraints() {
        
        HomeView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.top + 44) // 전체 높이
        }
        searchBoxView.snp.makeConstraints{
            $0.trailing.equalTo(HomeView).offset(-10)
            $0.centerY.equalTo(navigationView)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        searchButton.snp.makeConstraints{
            $0.edges.equalTo(searchBoxView)
        }
    }
    
    func homeSetupAction() {
        searchButton.addTarget(self, action: #selector(clickSearchButton), for: .touchUpInside)
    }
    
    @objc func clickSearchButton() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
