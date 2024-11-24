//
//  PerformanceTests.swift
//  DecisionJournalTests
//
//  Created by Gerard Gomez on 11/24/24.
//

import XCTest
@testable import DecisionJournal

final class PerformanceTests: XCTestCase {
    var metricsManager: MetricsManager!
    var decisions: [Decision]!
    
    override func setUp() {
        super.setUp()
        metricsManager = MetricsManager()
        decisions = (1...1_000_000).map { index in
            Decision(title: "Test Decision \(index)", priority: Decision.Priority.allCases.randomElement()!)
        }
    }
    override func tearDown() {
        metricsManager = nil
        decisions = nil
        super.tearDown()
    }
    @MainActor
    func testPriorityDistributionPerformance() {
        measure {
            _ = metricsManager.priorityDistribution(decisions: decisions)
        }
    }
}
