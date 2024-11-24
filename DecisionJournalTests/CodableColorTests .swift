//
//  CodableColorTests .swift
//  DecisionJournalTests
//
//  Created by Gerard Gomez on 11/19/24.
//

import Testing
import SwiftUI
@testable import DecisionJournal

struct CodableColorTests {
    
    @Test func testColorEncodingDecoding() {
        // Given
        let originalColor = Color.blue
        let codableColor = CodableColor(color: originalColor)
        
        // When
        let data = try? JSONEncoder().encode(codableColor)
        let decodedCodableColor = try? JSONDecoder().decode(CodableColor.self, from: data!)
        let decodedColor = decodedCodableColor?.toColor
        
        // Then
        #expect(decodedColor != nil)
        #expect(abs(decodedColor!.toRGBA!.red - originalColor.toRGBA!.red) < 0.001)
        #expect(abs(decodedColor!.toRGBA!.green - originalColor.toRGBA!.green) < 0.001)
        #expect(abs(decodedColor!.toRGBA!.blue - originalColor.toRGBA!.blue) < 0.001)
        #expect(abs(decodedColor!.toRGBA!.alpha - originalColor.toRGBA!.alpha) < 0.001)
    }
}

