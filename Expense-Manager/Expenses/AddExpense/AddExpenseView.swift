//
//  AddExpenseView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.modelContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    //@State private var categories: [ExpenseCategory] = [.init(id: UUID(), name: "asfasf"), .init(id: .init(), name: "asfs")] // For testing
    @Query(sort: \ExpenseCategory.name) private var categories: [ExpenseCategory]
    
    @State var config: AddExpenseViewConfig
    @State var expense: Expense
    
    init(config: AddExpenseViewConfig) {
        self.config = config
        
        switch config {
        case .Add:
            @AppStorage(UserDefaultString.UserCurrentSelectedCurrency.rawValue) var currencyCode = Currency.USD.code
            expense = .init(id: UUID(), name: "", category: nil, amount: 0, currency: currencyCode, dateOfExpense: .now, lastUpdated: .now)
        case .Edit(let expense):
            self.expense = expense
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Add expense")
                .bold()
                .padding()
            
            HStack {
                Text("Name")
                    .bold()
                
                Spacer()
                TextField("Table", text: $expense.name)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 200)
            }
            
            HStack(spacing: 0) {
                Text("Amount")
                    .bold()
                
                Spacer()
                
                TextField("$0.00", value: $expense.amount, format: .currency(code: expense.currency))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
            }
            
            HStack {
                Text("Currency*")
                    .bold()
                
                Spacer()
                Picker("Currency", selection: $expense.currency) {
                    ForEach(Currency.allCases, id: \.code) { item in
                        Text(item.code)
                    }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Text("Category")
                    .bold()
                
                Spacer()
                Picker("Category", selection: $expense.category) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.name)
                            .tag(category)
                    }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Text("Date")
                    .bold()
                Spacer()
                DatePicker("Date", selection: $expense.dateOfExpense, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
            Spacer()
            
            HStack {
                Text("*Update default currency in settings.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.bottom)
            
            Button("Save") {
                saveExpense()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private func saveExpense() {
        let name = expense.name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty,
              expense.category != nil else { return }
        expense.lastUpdated = .now
        moc.insert(expense)
        dismiss()
    }
}

#Preview {
    @Previewable @State var showSheet = true
    
    Button("Parent view") { showSheet = true }
        .sheet(isPresented: $showSheet) {
            AddExpenseView(config: .Add)
                .presentationDetents([.medium])
        }
    
}
