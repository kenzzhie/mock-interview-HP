//
//  InfoRow.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(label):")
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            Text(value)
                .bold()
        }
        .font(.subheadline)
    }
}

#Preview {
    InfoRow(label: "test", value: "value")
}
