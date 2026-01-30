//
//  SettingsListView.swift
//  Expense-Manager
//
//  Created by Harshit on 1/29/26.
//

import SwiftUI

struct SettingsListView: View {
    @AppStorage(UserDefaultString.UserCurrentSelectedCurrency.rawValue) var currency = Currency.USD.code
    
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
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsListView()
}
