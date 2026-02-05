//
//  SettingsListView.swift
//  Expense-Manager
//
//  Created by Harshit on 1/29/26.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct SettingsListView: View {
    @AppStorage(UserDefaultString.UserCurrentSelectedCurrency.rawValue) private var currency = Currency.USD.code
    @Query private var expenses: [Expense]
    private var exportedExpense: [Expense] = []
    
#if DEBUG
    @Environment(\.modelContext) var moc
    @Query private var categories: [ExpenseCategory]
#endif
    
    @State private var export: Bool = false
    @State private var document: ExcelDocument?
    
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
                    Button("Export(.csv)") {
                        prepareCSV()
                    }
                    
                    Button("Export(.json)") {
                        prepareJson()
                    }
                    .fileExporter(
                        isPresented: $export,
                        document: document,
                        contentType: .spreadsheet, // Specify the correct UTI
                        defaultFilename: "Expenses.csv"
                    ) { result in
                        switch result {
                        case .success(let url):
                            print("Exported to: \(url)")
                        case .failure(let error):
                            print("Export failed: \(error.localizedDescription)")
                        }
                    }
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

extension SettingsListView {
    func prepareJson() {
        do {
            let encodedExpenses = try JSONEncoder().encode(expenses)
            let json = try JSONSerialization.jsonObject(with: encodedExpenses, options: .fragmentsAllowed)
            print(json)
        } catch {
            print(error)
        }
    }
    
    func prepareCSV() {
        do {
//            let encodedExpenses = try JSONEncoder().encode(expenses)
//            let config = FileDocumentReadConfiguration(r)
//            self.document = try ExcelDocument(configuration: .init()
//            self.export = true
        } catch {
            print(error)
        }
    }
}

#Preview {
    SettingsListView()
}
