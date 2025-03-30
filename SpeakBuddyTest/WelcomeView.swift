//
//  WelcomeView.swift
//  SpeakBuddyTest
//
//  Created by Fadil on 30/03/25.
//

import SwiftUI
import AVKit

//struct WelcomeView: View {
//    @StateObject private var viewModel = ViewModel()
//    @Environment(\.presentationMode) var presentationMode
//    @Environment(\.horizontalSizeClass) var sizeClass
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                // Background
//                BackgroundView()
//
//                VStack(spacing: 24) {
//                    // Close button
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Image(systemName: "xmark")
//                                .font(.system(size: 16, weight: .bold))
//                                .foregroundColor(.black)
//                                .padding()
//                                .background(Circle().fill(Color.white))
//                        }
//                        .padding(.top, 60)
//                        .padding(.trailing, 24)
//                    }
//
//                    Spacer(minLength: 20)
//
//                    // Title
//                    VStack(spacing: 0) {
//                        Text("Hello")
//                            .font(.system(size: 36, weight: .bold))
//                        Text("SpeakBUDDY")
//                            .font(.system(size: 36, weight: .bold))
//                    }
//
//                    // Robot + Chart/Video
//                    chartWithRobot(geometry: geometry)
//
//                    // Bottom texts
//                    VStack(spacing: 10) {
//                        Text("スピークバディで")
//                            .font(.system(size: 24))
//                        Text("レベルアップ")
//                            .font(.system(size: 32, weight: .bold))
//                            .foregroundColor(.blue)
//                    }
//
//                    // Register button
//                    Button(action: {
//                        viewModel.registerPlan()
//                    }) {
//                        Text("プランに登録する")
//                            .font(.system(size: 18, weight: .bold))
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 56)
//                            .background(
//                                RoundedRectangle(cornerRadius: 30)
//                                    .fill(Color.blue)
//                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
//                            )
//                    }
//                    .padding(.horizontal)
//
//                    Spacer(minLength: 40)
//                }
//                .padding(.horizontal)
//            }
//            .ignoresSafeArea()
//            .onAppear {
//                viewModel.startAnimation()
//            }
//        }
//    }
//
//    // MARK: - Chart + Robot Layout
//    private func chartWithRobot(geometry: GeometryProxy) -> some View {
//        let viewSize = getViewSizeClass(geometry)
////        let isLandscape = geometry.size.width > geometry.size.height
//
//        let robotWidth: CGFloat
//        let chartWidth: CGFloat
//        let chartHeight: CGFloat
//
//        switch viewSize {
//            case .smallPhone:
//                robotWidth = geometry.size.width * 0.25
//                chartWidth = geometry.size.width * 0.7
//                chartHeight = geometry.size.height * 0.3
//                
//            case .largePhone:
//                robotWidth = geometry.size.width * 0.22
//                chartWidth = geometry.size.width * 0.65
//                chartHeight = geometry.size.height * 0.33
//
//            case .tabletPortrait:
//                robotWidth = geometry.size.width * 0.2
//                chartWidth = geometry.size.width * 0.6
//                chartHeight = geometry.size.height * 0.35
//
//            case .tabletLandscape:
//                robotWidth = geometry.size.width * 0.14
//                chartWidth = geometry.size.width * 0.55
//                chartHeight = geometry.size.height * 0.5
//        }
//
//        return ZStack {
//            chartOrVideo(width: chartWidth, height: chartHeight)
//
//            Image(ImageResource(name: "protty", bundle: .main))
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: robotWidth)
//                .offset(x: -robotWidth * 0.8, y: -geometry.size.height * 0.08)
//        }
//        .frame(height: chartHeight + 30)
//        .frame(maxWidth: .infinity)
//    }
//
//    // MARK: - Chart or Video View
//    private func chartOrVideo(width: CGFloat, height: CGFloat) -> some View {
//        Group {
//            if let videoURL = Bundle.main.url(forResource: "graph_animation_demo", withExtension: "mov") {
//                VideoPlayerView(videoURL: videoURL)
//                    .disabled(true)
//            } else {
//                BarChartView(animationProgress: viewModel.animationProgress)
//            }
//        }
//        .frame(width: width, height: height)
//        .aspectRatio(contentMode: .fit)
//    }
//
//    // MARK: - Size Classification
//    enum ViewSizeClass {
//        case smallPhone, largePhone, tabletPortrait, tabletLandscape
//    }
//
//    func getViewSizeClass(_ geometry: GeometryProxy) -> ViewSizeClass {
//        let width = geometry.size.width
//        let height = geometry.size.height
//
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return width > height ? .tabletLandscape : .tabletPortrait
//        } else {
//            return max(width, height) > 800 ? .largePhone : .smallPhone
//        }
//    }
//}

struct WelcomeView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundView().ignoresSafeArea()

                ScrollView {
                    VStack(spacing: spacing(for: geometry)) {
                        topBar

                        Spacer(minLength: 20)

                        titleSection

                        chartWithRobot(geometry: geometry)

                        bottomTexts

                        registerButton
                            .padding(.horizontal)

                        Spacer(minLength: bottomSpacing(for: geometry))
                    }
                    .padding(.horizontal)
                }
                .ignoresSafeArea()
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
            .padding(.top, 60)
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

//        let robotWidth: CGFloat = device == .pad ? geometry.size.width * 0.12 : geometry.size.width * 0.2
        let robotWidth: CGFloat = {
            if device == .pad {
                return isLandscape ? geometry.size.width * 0.12 : geometry.size.width * 0.2
            } else {
                return isLandscape ? geometry.size.height * 0.3 : geometry.size.width * 0.28
            }
        }()

        let chartWidth: CGFloat = device == .pad ? geometry.size.width * 0.5 : geometry.size.width * 0.65
        let chartHeight: CGFloat = isLandscape ? geometry.size.height * 0.5 : geometry.size.height * 0.35
        let offsetY: CGFloat = device == .pad ? -chartHeight * 0.3 : -chartHeight * 0.25

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
