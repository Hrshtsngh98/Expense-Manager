//
//  CurrencyConstants.swift
//  Expense-Manager
//
//  Created by Harshit on 1/29/26.
//

import Foundation

enum Currency: String, CaseIterable {
    case USD
    case EUR
    case INR
    
    var code: String {
        self.rawValue
    }
}
