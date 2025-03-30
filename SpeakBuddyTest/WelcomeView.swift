//
//  WelcomeView.swift
//  SpeakBuddyTest
//
//  Created by Fadil on 30/03/25.
//

import SwiftUI
import AVKit

struct WelcomeView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            let device = UIDevice.current.userInterfaceIdiom
            let isLandscape = geometry.size.width > geometry.size.height

            ZStack {
                BackgroundView()
                    .ignoresSafeArea()

                VStack(spacing: spacing(for: geometry)) {
                    topBar

//                    Spacer(minLength: isLandscape ? 8 : 16)

                    titleSection

                    chartWithRobot(geometry: geometry)

                    bottomTexts

//                    Spacer(minLength: isLandscape ? 8 : 16)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .safeAreaInset(edge: .bottom) {
                    registerButton
                        .padding(.horizontal)
                        .padding(.all, 24)
                }
            }
            .onAppear { viewModel.startAnimation() }
        }
    }

    // MARK: - Top Close Button
    var topBar: some View {
        HStack {
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                    .background(Circle().fill(Color.white))
            }
            .padding(.top, 48)
            .padding(.trailing, 24)
        }
    }

    // MARK: - Title Section
    var titleSection: some View {
        VStack(spacing: 0) {
            Text("Hello")
                .font(.system(size: 36, weight: .bold))
            Text("SpeakBUDDY")
                .font(.system(size: 36, weight: .bold))
        }
        .padding(.top, 24)
    }

    // MARK: - Bottom Texts
    var bottomTexts: some View {
        VStack(spacing: 10) {
            Text("スピークバディで")
                .font(.system(size: 24))
            Text("レベルアップ")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)
        }
    }

    // MARK: - Register Button
    var registerButton: some View {
        Button(action: {
            viewModel.registerPlan()
        }) {
            Text("プランに登録する")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.blue)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
        }
    }

    // MARK: - Chart and Robot View
    private func chartWithRobot(geometry: GeometryProxy) -> some View {
        let device = UIDevice.current.userInterfaceIdiom
        let isLandscape = geometry.size.width > geometry.size.height

        let robotWidth: CGFloat = {
            if device == .pad {
                return isLandscape ? geometry.size.width * 0.1 : geometry.size.width * 0.18
            } else {
                return isLandscape ? geometry.size.height * 0.25 : geometry.size.width * 0.28
            }
        }()

        let chartWidth: CGFloat = device == .pad ? geometry.size.width * 0.5 : geometry.size.width * 0.65
        let chartHeight: CGFloat = isLandscape ? geometry.size.height * 0.4 : geometry.size.height * 0.5
        let offsetY: CGFloat = device == .pad ? -chartHeight * 0.25 : -chartHeight * 0.2

        return ZStack {
            chartOrVideo(width: chartWidth, height: chartHeight)

            Image(ImageResource(name: "protty", bundle: .main))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: robotWidth)
                .offset(x: -robotWidth * 0.8, y: offsetY)
        }
        .frame(height: chartHeight + 30)
    }

    // MARK: - Chart or Video Player
    private func chartOrVideo(width: CGFloat, height: CGFloat) -> some View {
        Group {
            if let videoURL = Bundle.main.url(forResource: "graph_animation_demo", withExtension: "mov") {
                VideoPlayerView(videoURL: videoURL)
                    .disabled(true)
            } else {
                BarChartView(animationProgress: viewModel.animationProgress)
            }
        }
        .frame(width: width, height: height)
        .aspectRatio(contentMode: .fit)
    }

    // MARK: - Dynamic Spacing
    private func spacing(for geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height * 0.03
    }

    private func bottomSpacing(for geometry: GeometryProxy) -> CGFloat {
        let isLandscape = geometry.size.width > geometry.size.height
        return isLandscape ? geometry.size.height * 0.02 : 40
    }
}


// MARK: - Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
