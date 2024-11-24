//
//  MetricsManagerTests.swift
//  DecisionJournalTests
//
//  Created by Gerard Gomez on 11/19/24.
//

import Testing
import XCTest
@testable import DecisionJournal
import Foundation

@MainActor
struct MetricsManagerTests {
    
    @Test func testTotalDecisions() {
        // Given
        let metricsManager = MetricsManager()
        let decisions = Decision.sampleDecisions
        
        // When
        let totalDecisions = metricsManager.totalDecisions(decisions: decisions)
        
        // Then
        #expect(totalDecisions == decisions.count)
    }
    
    @Test func testAverageReflectionRating() {
        // Given
        let metricsManager = MetricsManager()
        let reflections = Reflection.sampleReflections
        
        // When
        let averageRating = metricsManager.averageReflectionRating(reflections: reflections)
        
        // Then
        let expectedAverage = reflections.map { Double($0.rating) }.reduce(0, +) / Double(reflections.count)
        #expect(abs(averageRating - expectedAverage) < 0.001)
    }
    
    @Test func testSuccessRate() {
        // Given
        let metricsManager = MetricsManager()
        let decisions = [
            Decision(title: "Decision 1", isSuccessful: true),
            Decision(title: "Decision 2", isSuccessful: false),
            Decision(title: "Decision 3", isSuccessful: true)
        ]
        
        // When
        let successRate = metricsManager.successRate(decisions: decisions)
        
        // Then
        #expect(abs(successRate - ((2.0 / 3.0) * 100)) < 0.001)
    }
    
    @Test func testPendingReflections() {
        // Given
        let metricsManager = MetricsManager()
        let decisions = [
            Decision(title: "Decision 1", reflections: []),
            Decision(title: "Decision 2", reflections: [Reflection(
                actualOutcomes: "",
                actualShortcomings: "",
                keyLearnings: "",
                improvementIdeas: "",
                reflectionDate: Date(),
                reflectionRating: 3
            )])
        ]
        
        // When
        let pendingReflections = metricsManager.pendingReflections(decisions: decisions)
        
        // Then
        #expect(pendingReflections == 1)
    }
}
