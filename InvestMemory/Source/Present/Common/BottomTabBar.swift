//
//  BottomTabBar.swift
//  InvestMemory
//
//  Created by calmkeen on 6/28/25.
//

import UIKit
import SnapKit
import Then

class BottomTabBar: UIViewController {
    
    var containerView = UIView()
    var tabStackView = UIStackView()
    var tabViews: [UIView] = []
    var selectedIndex: Int = -1 // 처음에는 아무것도 선택되지 않음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        view.addSubview(containerView)
        
        tabStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 0
            $0.alignment = .fill
        }
        
        containerView.addSubview(tabStackView)
        
        // 탭 정보 설정
        let tabItems = [
            ("캘린더", "calendar.circle", "calendar.circle.fill"),
            ("거래", "chart.line.uptrend.xyaxis", "chart.line.uptrend.xyaxis"),
            ("홈", "house", "house.fill"),
            ("분석", "chart.pie", "chart.pie.fill"),
            ("종목", "list.bullet", "list.bullet")
        ]
        
        for (index, (title, imageName, selectedImageName)) in tabItems.enumerated() {
            let tabView = createTabView(title: title, imageName: imageName, selectedImageName: selectedImageName, tag: index)
            tabViews.append(tabView)
            tabStackView.addArrangedSubview(tabView)
        }
        
        // 처음에는 아무것도 선택하지 않음 (이 줄 제거!)
        // selectTab(at: 0)
    }
    
    func createTabView(title: String, imageName: String, selectedImageName: String, tag: Int) -> UIView {
        let containerView = UIView()
        
        // 세로 스택뷰 생성
        let verticalStackView = UIStackView().then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 4
        }
        
        // 이미지뷰 생성
        let imageView = UIImageView().then {
            $0.image = UIImage(systemName: imageName)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .systemGray // 처음에는 모두 회색
        }
        
        // 라벨 생성
        let titleLabel = UILabel().then {
            $0.text = title
            $0.font = .systemFont(ofSize: 10)
            $0.textColor = .systemGray // 처음에는 모두 회색
            $0.textAlignment = .center
        }
        
        // 스택뷰에 추가
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
        
        containerView.addSubview(verticalStackView)
        
        // 제약조건 설정
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        // 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
        containerView.tag = tag
        
        // 선택/비선택 상태 저장을 위한 데이터 저장
        containerView.accessibilityLabel = imageName
        containerView.accessibilityHint = selectedImageName
        
        return containerView
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tabStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func tabTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view else { return }
        selectTab(at: tappedView.tag)
    }
    
    func selectTab(at index: Int) {
        // 이전 선택된 탭 기억
        let previousIndex = selectedIndex
        selectedIndex = index
        
        // 모든 탭 비선택 상태로 변경
        for (i, tabView) in tabViews.enumerated() {
            let stackView = tabView.subviews.first as! UIStackView
            let imageView = stackView.arrangedSubviews[0] as! UIImageView
            let titleLabel = stackView.arrangedSubviews[1] as! UILabel
            
            if i == index {
                // 선택된 탭
                imageView.image = UIImage(systemName: tabView.accessibilityHint!) // selectedImageName
                imageView.tintColor = .systemBlue
                titleLabel.textColor = .systemBlue
            } else {
                // 비선택된 탭
                imageView.image = UIImage(systemName: tabView.accessibilityLabel!) // imageName
                imageView.tintColor = .systemGray
                titleLabel.textColor = .systemGray
            }
        }
        
        // 탭 변경 로직
        switch index {
        case 0:
            print("캘린더 탭 선택")
        case 1:
            print("거래 탭 선택")
        case 2:
            print("홈 탭 선택")
        case 3:
            print("분석 탭 선택")
        case 4:
            print("종목 탭 선택")
        default:
            break
        }
    }
}
