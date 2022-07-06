//
//  TrailingIconLabel.swift
//  ScrumDinger
//
//  Created by Furkan Can Baytemur on 24.06.2022.
//

import SwiftUI

struct TrailinIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailinIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
