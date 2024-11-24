//
//  RatingView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    private let maxRating = 5
    let icon: String
    let color: Color
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { value in
                Image(systemName: icon)
                    .symbolVariant(value <= rating ? .fill : .none)
                    .foregroundColor(color)
                    .onTapGesture {
                        if value != rating {
                            rating = value
                        } else {
                            rating = 0
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var rating: Int = 1
    RatingView(rating: $rating, icon: "star", color: .mint)
}
