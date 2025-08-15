//
//  baseViewController.swift
//  InvestMemory
//
//  Created by calmkeen on 6/28/25.
//

import UIKit
import SnapKit
import Then

class BaseViewController : UIViewController{
     
    //Mark: - Base viewcontroller
    /*
     Need 
     하단 탭 
     검색창이 여기 필요한가?
     여기서 히든을 하는건가? 아니면 따로 분리 후 히든인가?
     무조건 분리가 맞음 -> 나중에 UI개편이나 문제상황 생길 경우 그게 조금 더. 맞긴함
     그럼 하단탭도 분리해야 하지 않나?
     그럼 이거 왜만듬?
     여러군데에서 재활용 할라고?
     일단 해봐.
     */
    
    var fullView = UIView()
    var searchBox = UIView()
    var bottomTabBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeConstraints()
    }
    
    func setupUI() {
        fullView = UIView().then {
            $0.backgroundColor = .white
        }
        
        searchBox = UIView().then {
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 8
        }
        
        bottomTabBar = UIView().then {
            $0.backgroundColor = .systemBackground
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: -2)
            $0.layer.shadowOpacity = 0.1
        }
        
        view.addSubview(fullView)
        fullView.addSubview(searchBox)
        fullView.addSubview(bottomTabBar)
    } 
    
    func makeConstraints() {
        fullView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchBox.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.1) 
        }
        
        bottomTabBar.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
