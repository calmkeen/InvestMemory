//
//  addSubView+.swift
//  InvestMemory
//
//  Created by calmkeen on 6/6/25.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
