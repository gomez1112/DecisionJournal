//
//  DashboardView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import Charts
import SwiftData
import SwiftUI

struct DashboardView: View {
    @Environment(\.modelContext) private var context
    @Environment(MetricsManager.self) private var metrics
    @Query private var decisions: [Decision]
    @Query private var reflections: [Reflection]
    @State private var isPresentingAddDecision = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    metricsSection
                    recentDecisionsSection
                    pendingReflectionsSection
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .toolbar {
                Button("Add Decision", systemImage: "plus") {
                    isPresentingAddDecision = true
                }
            }
            .sheet(isPresented: $isPresentingAddDecision) {
                AddDecisionView()
            }
            .presentationSizing(.form)
        }
    }
    private var metricsSection: some View {
        VStack(alignment: .leading) {
            Text("Key Metrics")
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                metricCard(title: "Total Decisions", value: "\(metrics.totalDecisions(decisions: decisions))", systemImage: "square.stack")
                metricCard(title: "Total Reflections", value: "\(metrics.totalReflections(reflections: reflections))", systemImage: "text.bubble")
            }
            HStack {
                metricCard(title: "Avg. Rating", value: metrics.averageReflectionRating(reflections: reflections).formatted(.number.precision(.fractionLength(2))), systemImage: "star")
                metricCard(title: "Success Rate", value: metrics.successRate(decisions: decisions).formatted(), systemImage: "checkmark.circle")
            }
            HStack {
                metricCard(title: "Pending Reflections", value: metrics.pendingReflections(decisions: decisions).formatted(), systemImage: "clock.badge.exclamationmark")
                metricCard(title: "Avg. decision to Reflection Time", value: metrics.averageDecisionToReflectionTime(reflections: reflections).formatted(), systemImage: "clock")
            }
        }
    }
    private func metricCard(title: String, value: String, systemImage: String) -> some View {
        VStack {
            HStack {
                Image(systemName: systemImage)
                    .font(.title)
                    .foregroundColor(.accentColor)
                Spacer()
                Text(value)
                    .font(.title.bold())
            }
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    
    private var recentDecisionsSection: some View {
        VStack(alignment: .leading) {
            Text("Recent Decisions")
                .font(.title2.bold())
            ForEach(decisions.prefix(3)) { decision in
                NavigationLink(value: decision) {
                    DecisionCardView(decision: decision)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationDestination(for: Decision.self) { decision in
            DecisionDetailView(decision: decision)
        }
    }

    private var pendingReflectionsSection: some View {
        VStack(alignment: .leading) {
            Text("Pending Reflections")
                .font(.title2.bold())
            let pendingDecisions = decisions.filter { ($0.reflections?.isEmpty ?? true)}
            if pendingDecisions.isEmpty {
                ContentUnavailableView("All decisions have reflections.", systemImage: "folder")
            } else {
                ForEach(pendingDecisions.prefix(3)) { decision in
                    NavigationLink(value: decision) {
                        DecisionCardView(decision: decision)
                            .buttonStyle(.plain)
                    }
                    .buttonStyle(.plain)
                }
            }
            
        }
    }
}

#Preview(traits: .previewData) {
    DashboardView()
}
