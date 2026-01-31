//
//  SettingsListView.swift
//  Expense-Manager
//
//  Created by Harshit on 1/29/26.
//

import SwiftUI
import SwiftData

struct SettingsListView: View {
    @AppStorage(UserDefaultString.UserCurrentSelectedCurrency.rawValue) private var currency = Currency.USD.code
    
    #if DEBUG
    @Environment(\.modelContext) var moc
    @Query private var categories: [ExpenseCategory]
    #endif
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Default currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { item in
                            Text(item.code)
                                .tag(item.code)
                        }
                    }
                }
                
                Section {
                    Text("Import(.csv)")
                    Text("Export(.csv)")
                }
                
                #if DEBUG
                Section("DEBUG") {
                    Button("Add Random") {                        
                        var comp = DateComponents()
                        comp.year = (2025...2027).randomElement()!
                        comp.month = (1...12).randomElement()!
                        comp.day = (1...28).randomElement()!
                        
                        let date = Calendar.current.date(from: comp)!
                        
                        moc.insert(Expense(
                            id: .init(),
                            name: ["table","car","toy","food","drink","beer","lamp"].randomElement()!,
                            category: categories.randomElement()!,
                            amount: Double.random(in: 1...100),
                            currency: Currency.USD.code,
                            dateOfExpense: date,
                            lastUpdated: .now))
                    }
                }
                #endif
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsListView()
}
