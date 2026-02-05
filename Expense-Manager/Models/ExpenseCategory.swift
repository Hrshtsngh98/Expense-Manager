//
//  ExpenseCategory.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import Foundation
import SwiftData

@Model
class ExpenseCategory: Encodable {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id.uuidString, forKey: .id)
        try? container.encode(name, forKey: .name)
    }
}
