//
//  ContentView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) var moc
    @Query(sort: [SortDescriptor(\Expense.dateOfExpense, order: .reverse)]) private var expenseList: [Expense]
    @Query private var categories: [ExpenseCategory]
    
    @State private var vm: ExpenseListVM = .init()
    @State private var showAddExpenseSheet = false
    @State private var showSortList = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenseList) { expense in
                    ExpenseItemView(expense: expense)
                }
                .onDelete { indexSet in
                    for offset in indexSet {
                        let item = expenseList[offset]
                        moc.delete(item)
                    }
                }
            }
            .navigationTitle("Expense")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(FilterOptions.allCases, id: \.rawValue) { sortBy in
                            Button(sortBy.rawValue) {
                                
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(SortOptions.allCases, id: \.rawValue) { sortBy in
                            Button(sortBy.rawValue) {
                                
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddExpenseSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddExpenseSheet) {
            AddExpenseView()
                .presentationDetents([.medium])
        }
    }
}


#Preview {
    ExpenseListView()
}
