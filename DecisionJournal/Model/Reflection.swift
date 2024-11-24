//
//  Reflection.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import SwiftData

@Model
final class Reflection {
    var actualOutcomes = ""
    var actualShortcomings = ""
    var keyLearnings = ""
    var improvementIdeas = ""
    var reflectionDate = Date()
    var rating = 3
    @Relationship var decision: Decision? = nil
    
    init(actualOutcomes: String, actualShortcomings: String, keyLearnings: String, improvementIdeas: String, reflectionDate: Date, reflectionRating: Int, decision: Decision? = nil) {
        self.actualOutcomes = actualOutcomes
        self.actualShortcomings = actualShortcomings
        self.keyLearnings = keyLearnings
        self.improvementIdeas = improvementIdeas
        self.reflectionDate = reflectionDate
        self.rating = reflectionRating
        self.decision = decision
    }
    
    // Sample Data for Reflections
    @MainActor static let sampleReflections: [Reflection] = [
        Reflection(
            actualOutcomes: "Successfully implemented the new attendance policy, and teachers are now using the system consistently.",
            actualShortcomings: "Initial resistance from staff caused a delay in full adoption.",
            keyLearnings: "Change management requires early communication and feedback loops.",
            improvementIdeas: "Conduct a pilot program with selected staff before full implementation.",
            reflectionDate: Date(),
            reflectionRating: 3,
            decision: nil
        ),
        Reflection(
            actualOutcomes: "Upgraded 80% of the school’s technology infrastructure.",
            actualShortcomings: "Ran over budget due to unforeseen hardware costs.",
            keyLearnings: "Include contingency funds in budget planning.",
            improvementIdeas: "Negotiate better contracts with vendors and conduct thorough budget analysis.",
            reflectionDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
            reflectionRating: 3,
            decision: nil // Replace with a related Decision instance if available
        ),
        Reflection(
            actualOutcomes: "Held a successful teacher training workshop attended by 95% of staff.",
            actualShortcomings: "A few teachers expressed that the session was too generic for their specific needs.",
            keyLearnings: "Workshops should be tailored to the audience's expertise and context.",
            improvementIdeas: "Gather pre-session surveys to understand specific needs and expectations.",
            reflectionDate: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
            reflectionRating: 5,
            decision: nil // Replace with a related Decision instance if available
        )
    ]
}

