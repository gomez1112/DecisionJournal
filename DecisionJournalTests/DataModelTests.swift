//
//  DataModelTests.swift
//  DecisionJournalTests
//
//  Created by Gerard Gomez on 11/19/24.
//

import Testing
import SwiftData
import SwiftUI
@testable import DecisionJournal

@MainActor
struct DataModelTests {
    
    static func makeTestContainer() throws -> ModelContainer {
        let schema = Schema([Category.self, Decision.self, Reflection.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try ModelContainer(for: schema, configurations: [configuration])
    }
    
    
    @Test func testSaveDecision() throws {
        // Given
        let container = try Self.makeTestContainer()
        let dataModel = DataModel(container: container)
        let decisionTitle = "Test Decision"
        let decisionDetail = "Test Detail"
        let tags = "tag1, tag2"
        let confidenceScore: Double = 7.0
        let isFavorite = true
        let selectedColor = Color.red
        let selectedPriority = Decision.Priority.high
        let selectedStatus = Decision.Status.ongoing
        let selectedCategory = Category(title: "Test Category")
        container.mainContext.insert(selectedCategory)
        
        // When
        dataModel.saveDecision(
            title: decisionTitle,
            detail: decisionDetail,
            tags: tags,
            confidenceScore: confidenceScore,
            isFavorite: isFavorite,
            selectedColor: selectedColor,
            selectedPriority: selectedPriority,
            selectedStatus: selectedStatus,
            selectedCategory: selectedCategory
        )
        
        // Then
        let fetchRequest = FetchDescriptor<Decision>()
        let decisions = try container.mainContext.fetch(fetchRequest)
        #expect(decisions.count == 1)
        let decision = decisions.first!
        #expect(decision.title == decisionTitle)
        #expect(decision.detail == decisionDetail)
        #expect(decision.tags == ["tag1", "tag2"])
        #expect(decision.confidenceScore == Int(confidenceScore))
        #expect(decision.isFavorite == isFavorite)
        #expect(abs(decision.color.toRGBA!.red - selectedColor.toRGBA!.red) < 0.001)
        #expect(decision.priority == selectedPriority)
        #expect(decision.status == selectedStatus)
        #expect(decision.category === selectedCategory)
    }
}

