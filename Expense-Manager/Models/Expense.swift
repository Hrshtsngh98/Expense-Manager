//
//  Expense.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import Foundation
import SwiftData

@Model
class Expense: Encodable {
    var id: UUID
    var name: String
    var category: ExpenseCategory?
    var amount: Double
    var currency: String
    var dateOfExpense: Date
    var lastUpdated: Date
    
    init(id: UUID, name: String, category: ExpenseCategory?, amount: Double, currency: String, dateOfExpense: Date, lastUpdated: Date) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.currency = currency
        self.dateOfExpense = dateOfExpense
        self.lastUpdated = lastUpdated
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case category
        case amount
        case currency
        case dateOfExpense
        case lastUpdated
    }
    
    func encode(to encoder: any Encoder) throws {
        (encoder as? JSONEncoder)?.dateEncodingStrategy = .iso8601
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(id.uuidString, forKey: .id)
        try? container.encode(name, forKey: .name)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encode(amount, forKey: .amount)
        try container.encode(currency, forKey: .currency)
        try container.encode(dateOfExpense, forKey: .dateOfExpense)
        try container.encode(lastUpdated, forKey: .lastUpdated)
    }
}
