//
//  SelectLoginView.swift
//  InvestMemory
//
//  Created by calmkeen on 8/16/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class SelectLogin : UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = selectBeforeLoginViewModel()
    
    var defaultView = UIView()
    var backgroundImage = UIImageView()
    var LoginConnectBtn = UIButton(type: .system)
    var guestConnectBtn = UIButton(type: .system)
    var connectGuideLB = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindValues()
        setupProperties()
        LoginConnectBtn.setTitle("LgoinBTn", for: .normal)
        guestConnectBtn.setTitle("guestBtn", for: .normal)
        connectGuideLB.text = "Test"
        
        bindViewModel()
    }   
    
    func setupUI() { //add View
        view.addSubview(defaultView)
        defaultView.addSubview(backgroundImage)
        defaultView.addSubview(LoginConnectBtn)
        defaultView.addSubview(guestConnectBtn)
        defaultView.addSubview(connectGuideLB)
    }
    
    func bindValues() { //add value in data binding
        
    }
    
    
    func setupProperties() { // value default option
        connectGuideLB.textAlignment = .center
        connectGuideLB.textColor = .white
    }
    
    func setupConstraints() { // UI Constraints
        let parentHeight = view.frame.height
        defaultView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints{ make in
            make.edges.equalTo(defaultView)
        }
        
        LoginConnectBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)

            // 부모 높이의 60% 지점 (위에서부터)
            make.top.equalToSuperview().offset(parentHeight * 0.6)
            }
        connectGuideLB.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(LoginConnectBtn.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        guestConnectBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(connectGuideLB.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)

            // 부모 높이의 60% 지점 (위에서부터)
            make.top.equalToSuperview().offset(parentHeight * 0.8)
            
        }
        
    } 
    
    func loginConnectBtnAction() {
        print("LoginConnectBtnAction")
    }
    
    func guestConnectBtnAction() {
        print("guestConnectBtnAction")
    } 
    
    func bindViewModel() {
        let input = selectBeforeLoginViewModel.Input(
            LoginConnectBtn: LoginConnectBtn.rx.tap.asObservable(),
            guestConnectBtn: guestConnectBtn.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.loginSelected
            .subscribe(onNext: { value in
                print(value) // Login 선택
            })
            .disposed(by: disposeBag)
        
        output.guestSelected
            .subscribe(onNext: { value in
                print(value) // Guest 선택
            })
            .disposed(by: disposeBag)
    }
} 
