//
//  AnalyticsView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import Charts
import SwiftData
import SwiftUI

struct AnalyticsView: View {
    @Environment(MetricsManager.self) private var metrics
    @Query private var decisions: [Decision]
    @Query private var reflections: [Reflection]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    successRateChart
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                    priorityDistributionChart
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                    confidenceScoreChart
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                    reflectionRatingChart
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .padding()
            }
            .navigationTitle("Analytics")
        }
    }

    private var successRateChart: some View {
        VStack(alignment: .leading) {
            Text("Success Rate Over Time")
                .font(.headline)
            Chart {
                ForEach(decisions) { decision in
                    LineMark(x: .value("Date", decision.date), y: .value("Success", decision.isSuccessful ? 1 : 0))
                        .interpolationMethod(.catmullRom)
                }
            }
            .chartYAxis {
                AxisMarks(values: [0, 1]) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(value.as(Int.self) == 1 ? "Success" : "Failure")
                }
            }
            .chartXAxis {
                AxisMarks(preset: .aligned, position: .bottom, values: .automatic(desiredCount: 5)) {
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month().day())
                }
            }
            .frame(height: 200)
        }
    }
    private var priorityDistributionChart: some View {
        VStack(alignment: .leading) {
            Text("Priority Distribution")
                .font(.headline)
            let distribution = metrics.priorityDistribution(decisions: decisions)
            Chart {
                ForEach(Decision.Priority.allCases) { priority in
                    BarMark(x: .value("Priority", priority.rawValue.capitalized), y: .value("Count", distribution[priority] ?? 0))
                        .foregroundStyle(by: .value("Priority", priority.rawValue))
                }
            }
            .frame(height: 200)
        }
    }
    private var confidenceScoreChart: some View {
        VStack(alignment: .leading) {
            Text("Average Confidence Score Over Time")
                .font(.headline)
            
            let groupedDecisions = Dictionary(grouping: decisions) { decision in
                Calendar.current.startOfDay(for: decision.date)
            }
            
            let averageScores = groupedDecisions.map { (date, decisions) -> (Date, Double) in
                let average = decisions.map { Double($0.confidenceScore) }.reduce(0, +) / Double(decisions.count)
                return (date, average)
            }.sorted { $0.0 < $1.0 }
            
            Chart {
                ForEach(averageScores, id: \.0) { (date, average) in
                    LineMark(
                        x: .value("Date", date),
                        y: .value("Average Score", average)
                    )
                }
            }
            .chartYScale(domain: 0...10)
            .frame(height: 200)
        }
    }
    private var reflectionRatingChart: some View {
        VStack(alignment: .leading) {
            Text("Reflection Ratings")
                .font(.headline)
            
            let ratings = reflections.map { $0.rating }
            let ratingCounts = Dictionary(grouping: ratings, by: { $0 }).mapValues { $0.count }
            
            Chart {
                ForEach(1...5, id: \.self) { rating in
                    BarMark(
                        x: .value("Rating", "\(rating) Stars"),
                        y: .value("Count", ratingCounts[rating] ?? 0)
                    )
                }
            }
            .frame(height: 200)
        }
    }
}

#Preview(traits: .previewData) {
    AnalyticsView()
}
