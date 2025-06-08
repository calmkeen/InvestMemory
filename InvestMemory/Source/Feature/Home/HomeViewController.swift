//
//  HomeView.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {
    private let newsTickerView = NewsTickerCell()
    private let topBar = TopNavigationBar()
    
    var HomeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var infoSliderView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        return uv
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
    }
    
    func setupValue() {
        topBar.onSearchTapped = { [weak self] in
            let searchVC = SearchViewController()
            self?.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    func addCompnent() {
        view.addSubview(HomeView)
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
    }
}
