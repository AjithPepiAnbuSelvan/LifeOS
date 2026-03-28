//
//  ContentView.swift
//  LifeOS
//
//  Created by Ajith Pepi Anbu Selvan on 16/03/26.
//

import SwiftUI
import SwiftData

enum LifeOSSection: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case finance = "Finance"
    case subscriptions = "Subscriptions"
    case inventory = "Inventory"
    case documents = "Documents"
    case maintenance = "Maintenance"
    case settings = "Settings"

    var id: String { rawValue }

    var systemImageName: String {
        switch self {
        case .dashboard: return "chart.bar"
        case .finance: return "wallet.pass"
        case .subscriptions: return "arrow.triangle.2.circlepath"
        case .inventory: return "shippingbox"
        case .documents: return "doc.text"
        case .maintenance: return "wrench.and.screwdriver"
        case .settings: return "gear"
        }
    }
}

struct ContentView: View {
    @State private var selectedSection: LifeOSSection? = .dashboard

    var body: some View {
        NavigationSplitView {
            List(LifeOSSection.allCases, selection: $selectedSection) { section in
                NavigationLink(value: section) {
                    Label(section.rawValue, systemImage: section.systemImageName)
                }
            }
            .navigationTitle("LifeOS")
        } detail: {
            Group {
                switch selectedSection {
                case .dashboard, .none:
                    DashboardView()
                case .finance:
                    FinanceView()
                case .subscriptions:
                    SubscriptionsView()
                case .inventory:
                    InventoryView()
                case .documents:
                    DocumentsView()
                case .maintenance:
                    MaintenanceView()
                case .settings:
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PersistenceController.preview.container)
}
