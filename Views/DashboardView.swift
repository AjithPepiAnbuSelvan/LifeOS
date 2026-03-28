import SwiftUI
import SwiftData

struct DashboardView: View {
	@Environment(\.modelContext) private var modelContext
	@StateObject private var viewModel: DashboardViewModel
	
	init() {
			// Temporary placeholder; real context is injected in body using onAppear.
		_viewModel = StateObject(wrappedValue: DashboardViewModel(context: ModelContext(PersistenceController.preview.container)))
	}
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				Text("Dashboard")
					.font(.largeTitle)
					.bold()
				
				// Primary balance card
				VStack(alignment: .leading, spacing: 8) {
					Text("Total Balance")
						.font(.headline)
						.foregroundStyle(.secondary)
					Text(formattedCurrency(viewModel.totalBalance))
						.font(.system(size: 34, weight: .bold, design: .rounded))
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(
					RoundedRectangle(cornerRadius: 16, style: .continuous)
						.fill(Color.accentColor.opacity(0.1))
				)
				
				// Row of two smaller cards
				HStack(spacing: 16) {
					smallCard(
						title: "Monthly Expenses",
						value: formattedCurrency(viewModel.monthlyExpenses),
						color: .red.opacity(0.15)
					)
					
					smallCard(
						title: "Active Subscriptions",
						value: "\(viewModel.activeSubscriptionsCount)",
						color: .blue.opacity(0.15)
					)
				}
				
				// Other metrics
				VStack(spacing: 12) {
					metricRow(
						title: "Upcoming Maintenance",
						value: "\(viewModel.upcomingMaintenanceCount)"
					)
					metricRow(
						title: "Expiring Documents",
						value: "\(viewModel.expiringDocumentsCount)"
					)
				}
				.padding()
				.background(
					RoundedRectangle(cornerRadius: 16, style: .continuous)
						.fill(Color(.secondarySystemBackground))
				)
				
				Spacer()
			}
			.padding()
		}
		.onAppear {
			viewModel.updateContext(modelContext)
		}
	}
	
	private func formattedCurrency(_ value: Decimal) -> String {
		let number = NSDecimalNumber(decimal: value)
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencyCode = "USD"
		return formatter.string(from: number) ?? "$0"
	}
	
	private func smallCard(title: String, value: String, color: Color) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(title)
				.font(.subheadline)
				.foregroundStyle(.secondary)
			Text(value)
				.font(.headline)
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(
			RoundedRectangle(cornerRadius: 14, style: .continuous)
				.fill(color)
		)
	}
	
	private func metricRow(title: String, value: String) -> some View {
		HStack {
			Text(title)
			Spacer()
			Text(value)
				.fontWeight(.semibold)
		}
	}
}

#Preview {
	DashboardView()
		.modelContainer(PersistenceController.preview.container)
}
