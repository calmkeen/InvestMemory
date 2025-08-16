//
//  selectBeforeLoginModel.swift
//  InvestMemory
//
//  Created by calmkeen on 8/16/25.
//

import Foundation
import RxSwift
import RxRelay

class selectBeforeLoginViewModel {
    
    
    struct Input {
        let LoginConnectBtn: Observable<Void>
        let guestConnectBtn: Observable<Void>
    }
    
    struct Output {
        let loginSelected: Observable<String>
        let guestSelected: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let loginSelected = input.LoginConnectBtn.map { "Login 선택됨" }
        let guestSelected = input.guestConnectBtn.map { "Guest 선택됨" }
        
        return Output(loginSelected: loginSelected,
                      guestSelected: guestSelected)
    }
    
    private func binding() {
        
    }1
    
    
}

