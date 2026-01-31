//
//  DashboardView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.modelContext) var moc
    @State private var showAddExpenseSheet = false
    @State private var vm: DashboardVM = .init()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Picker("Period", selection: $vm.expensePeriod) {
                        ForEach(ExpensePeriod.allCases, id: \.self) { period in
                            Text(period.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: vm.expensePeriod) { _,_ in
                        vm.setupSummaryPredicate()
                    }
                    
                    HStack {
                        DashExpenseSummaryView(filter: vm.summaryPredicate)
                            .id(vm.expensePeriod)
                        Spacer()
                    }
                    .padding()
                    
                    DashExpenseCategoryView(filter: vm.summaryPredicate)
                        .id(vm.expensePeriod)
                    
                    Spacer()
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
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
            AddExpenseView(config: .Add)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    DashboardView()
}
