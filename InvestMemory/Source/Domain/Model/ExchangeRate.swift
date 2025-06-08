//
//  ExchangeRate.swift
//  InvestMemory
//
//  Created by calmkeen on 6/8/25.
//


import Foundation

struct ExchangeRate: Decodable {
    let curUnit: String      // 통화 단위 (ex. "USD")
    let curName: String      // 통화 이름 (ex. "미국 달러")
    let dealBaseRate: String // 매매 기준율 (ex. "1066.9")

    enum CodingKeys: String, CodingKey {
        case curUnit = "cur_unit"
        case curName = "cur_nm"
        case dealBaseRate = "deal_bas_r"
    }
}
