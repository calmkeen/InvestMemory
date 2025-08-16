//
//  SearchViewController.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit
import SnapKit
import Then

class SearchViewController: UIViewController {
    
    var searchBoxView = UIView().then {
        let view = UIView()
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15   
    }
    var searchButton = UIButton().then {
        $0.sizeToFit()
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .systemGray // 색상 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addCompnent()
        addConstraints()
    }
    func addCompnent() {
        view.addSubview(searchBoxView)
        searchBoxView.addSubview(searchButton)
        
    }
    
    func addConstraints() {
        searchBoxView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        searchButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(44)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24) // iOS 표준 터치 영역
        }
        
    }
    
}
