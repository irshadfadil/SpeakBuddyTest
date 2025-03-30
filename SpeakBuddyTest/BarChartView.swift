//
//  BarChartView.swift
//  SpeakBuddyTest
//
//  Created by Fadil on 30/03/25.
//

import SwiftUI

struct BarChartView: View {
    let animationProgress: CGFloat

    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            barColumn(height: 60 * animationProgress, label: "現在")
            barColumn(height: 120 * animationProgress, label: "3ヶ月")
            barColumn(height: 180 * animationProgress, label: "1年")
            barColumn(height: 240 * animationProgress, label: "2年")
        }
        .padding(.bottom, 20)
    }

    private func barColumn(height: CGFloat, label: String) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 0.6, green: 0.8, blue: 1.0)) // Light blue
                .frame(width: 60, height: height)

            Text(label)
                .font(.system(size: 14))
                .padding(.top, 5)
        }
    }
}

#Preview {
    BarChartView(animationProgress: 1.0)
}
