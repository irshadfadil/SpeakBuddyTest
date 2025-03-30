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
            let isLandscape = geometry.size.width > geometry.size.height
            let isPhone = UIDevice.current.userInterfaceIdiom == .phone
            let needsScroll = isPhone && isLandscape

            ZStack {
                BackgroundView()
                    .ignoresSafeArea()

                if needsScroll {
                    ScrollView {
                        contentStack(geometry: geometry)
                    }
                    .ignoresSafeArea()
                } else {
                    contentStack(geometry: geometry)
                }
            }
            .onAppear { viewModel.startAnimation() }
        }
    }

    // MARK: - Content
    func contentStack(geometry: GeometryProxy) -> some View {
        VStack(spacing: spacing(for: geometry)) {
            topBar(geometry: geometry)
            titleSection(geometry: geometry)
            chartWithRobot(geometry: geometry)
            bottomTexts(geometry: geometry)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .safeAreaInset(edge: .bottom) {
            registerButton(geometry: geometry)
                .padding(.horizontal)
                .padding(.top, geometry.size.height < 650 ? 8 : 12)
                .padding(.bottom, geometry.size.height < 650 ? 4 : 8)
        }
    }

    // MARK: - Top Close Button
    func topBar(geometry: GeometryProxy) -> some View {
        let minSide = min(geometry.size.width, geometry.size.height)
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let buttonSize: CGFloat = isPad ? 20 : (minSide < 375 ? 14 : 16)
        let topPadding: CGFloat = isPad ? 56 : (minSide < 375 ? 40 : 48)

        return HStack {
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: buttonSize, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                    .background(Circle().fill(Color.white))
            }
            .padding(.top, topPadding)
            .padding(.trailing, 24)
        }
    }

    // MARK: - Title Section
    func titleSection(geometry: GeometryProxy) -> some View {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let minSide = min(geometry.size.width, geometry.size.height)
        let titleSize: CGFloat = isPad ? 48 : (minSide < 375 ? 28 : 36)

        return VStack(spacing: 0) {
            Text("Hello")
                .font(.system(size: titleSize, weight: .bold))
            Text("SpeakBUDDY")
                .font(.system(size: titleSize, weight: .bold))
        }
    }

    // MARK: - Bottom Texts
    func bottomTexts(geometry: GeometryProxy) -> some View {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let minSide = min(geometry.size.width, geometry.size.height)
        let subTextSize: CGFloat = isPad ? 28 : (minSide < 375 ? 20 : 24)
        let mainTextSize: CGFloat = isPad ? 36 : (minSide < 375 ? 28 : 32)

        return VStack(spacing: 10) {
            Text("スピークバディで")
                .font(.system(size: subTextSize))
            Text("レベルアップ")
                .font(.system(size: mainTextSize, weight: .bold))
                .foregroundColor(.blue)
        }
    }

    // MARK: - Register Button
    func registerButton(geometry: GeometryProxy) -> some View {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let minSide = min(geometry.size.width, geometry.size.height)
        let fontSize: CGFloat = isPad ? 22 : (minSide < 375 ? 16 : 18)

        return Button(action: {
            viewModel.registerPlan()
        }) {
            Text("プランに登録する")
                .font(.system(size: fontSize, weight: .bold))
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
        let chartHeight: CGFloat = {
            if device == .pad {
                return isLandscape ? geometry.size.height * 0.4 : geometry.size.height * 0.5
            } else {
                return isLandscape ? geometry.size.height * 0.45 : geometry.size.height * 0.35
            }
        }()
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
