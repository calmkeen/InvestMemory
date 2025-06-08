//
//  TopNavigationBar.swift
//  InvestMemory
//
//  Created by calmkeen on 6/8/25.
//

import UIKit
import SnapKit

class TopNavigationBar: UIView {
    
    var onSearchTapped: (() -> Void)?
    
    var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupValue()
        addUIView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupValue()
        addUIView()
        addConstraints()
    }
    
    func setupValue() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
    }
    func addUIView() {
        addSubview(containerView)
        containerView.addSubview(searchBoxView)
        searchBoxView.addSubview(searchButton)
    }
    
    func addConstraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(containerView.safeAreaInsets.top + 44) // 전체 높이
        }
        searchBoxView.snp.makeConstraints{
            $0.trailing.equalTo(containerView).offset(-10)
            $0.centerY.equalTo(containerView)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        searchButton.snp.makeConstraints{
            $0.edges.equalTo(searchBoxView)
        }
    }
    
    private func setupAction() {
        searchButton.addTarget(self, action: #selector(tapSearch), for: .touchUpInside)
    }
    
    @objc private func tapSearch() {
        onSearchTapped?()
    }
    
    func timer() {
        //        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
        //            let nextIndex = (currentIndex + 1) % newsItems.count
        //            collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
        //            currentIndex = nextIndex
        //        }
    }
}
