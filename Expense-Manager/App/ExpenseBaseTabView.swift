//
//  ExpenseBaseTabView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct ExpenseBaseTabView: View {
    @Environment(\.modelContext) private var moc
    @Query private var categories: [ExpenseCategory]
    
    var body: some View {
        TabView {
            Tab {
                DashboardView()
            } label: {
                Image(systemName: "square.grid.3x3.square")
                Text("Dashboard")
            }
            
            Tab {
                ExpenseListView()
            } label: {
                Image(systemName: "square.text.square")
                Text("Expenses")
            }
            
            Tab {
                CategoriesListView()
            } label: {
                Image(systemName: "list.bullet")
                Text("Categories")
            }
            
            Tab {
                SettingsListView()
            } label: {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .tabViewBottomAccessory(content: {
            Button("Add Random") {
                var comp = DateComponents()
                comp.year = (2024...2027).randomElement()!
                comp.month = (1...12).randomElement()!
                comp.day = (1...28).randomElement()!
                
                let date = Calendar.current.date(from: comp)!
                
                moc.insert(Expense(
                    id: .init(),
                    name: ["table", "car","toy","food","drink","beer","lamp"].randomElement()!,
                    category: categories.randomElement()!,
                    amount: Double.random(in: 1...100),
                    currency: Currency.USD.code,
                    dateOfExpense: date,
                    lastUpdated: .now))
            }
        })
        .onAppear {
            prepareCategories()
        }
    }
    
    private func prepareCategories() {
        if categories.isEmpty {
            let cat1 = ExpenseCategory(id: .init(), name: "Rent")
            let cat2 = ExpenseCategory(id: .init(), name: "Grocery")
            let cat3 = ExpenseCategory(id: .init(), name: "Shopping")
            let cat4 = ExpenseCategory(id: .init(), name: "Electricity")
            let cat5 = ExpenseCategory(id: .init(), name: "Restaurants")
            let cat6 = ExpenseCategory(id: .init(), name: "Sports")
            let cat7 = ExpenseCategory(id: .init(), name: "Travel")
            let cat8 = ExpenseCategory(id: .init(), name: "General")
            let cat9 = ExpenseCategory(id: .init(), name: "Phone & Internet")
            
            moc.insert(cat1)
            moc.insert(cat2)
            moc.insert(cat3)
            moc.insert(cat4)
            moc.insert(cat5)
            moc.insert(cat6)
            moc.insert(cat7)
            moc.insert(cat8)
            moc.insert(cat9)
        }
    }
}

#Preview {
    ExpenseBaseTabView()
}
