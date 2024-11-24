//
//  PreviewTrait+Extension.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import DeveloperToolsSupport

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var previewData: Self = .modifier(PreviewData())
}
