//
//  ReviewView.swift
//  YHT
//
//  Created by 이건준 on 12/14/23.
//

import SwiftUI

struct ReviewView: View {
    
    @ObservedObject private var reviewViewModel: ReviewViewModel
    @State private var colorScheme: ColorScheme = .light
    
    init(reviewViewModel: ReviewViewModel) {
        self.reviewViewModel = reviewViewModel
    }
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 180, height: 90)
                .padding(.bottom, 50)
                .padding(.top, 20)
            
            ScrollView(showsIndicators: false) {
                HStack {
                    Text("운동 후 자극 부위 선택")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal, 20)
                
                HStack {
                    ZStack {
                        Image("img_muscle_front_body")
                            .resizable()
                            .frame(width: 150, height: 320)
                            .scaledToFill()
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let location = value.location
                                    if isAbsRange(location: location) {
                                        reviewViewModel.isAbsShow = !reviewViewModel.isAbsShow
                                    }
                                    
                                    if isLeftBicepsRange(location: location) || isRightBicepsRange(location: location) {
                                        reviewViewModel.isBicepsShow = !reviewViewModel.isBicepsShow
                                    }
                                    
                                    if isRightCalvesRange(location: location) || isLeftCalvesRange(location: location) {
                                        reviewViewModel.isCalvesShow = !reviewViewModel.isCalvesShow
                                    }
                                    
                                    if isChestRange(location: location) {
                                        reviewViewModel.isChestShow = !reviewViewModel.isChestShow
                                    }
                                    
                                    if isLeftForearmsRange(location: location) || isRightForearmsRange(location: location) {
                                        reviewViewModel.isForearmsShow = !reviewViewModel.isForearmsShow
                                    }
                                    
                                    if isRightQuadricepsRange(location: location) || isLeftQuadricepsRange(location: location) {
                                        reviewViewModel.isQuadricepsShow = !reviewViewModel.isQuadricepsShow
                                    }
                                    
                                    if isLeftShoulderRange(location: location) || isRightShoulderRange(location: location) {
                                        reviewViewModel.isShoulderShow = !reviewViewModel.isShoulderShow
                                    }
                                }
                            )
                        
                        if reviewViewModel.isAbsShow {
                            Image("img_front_abs")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isBicepsShow {
                            Image("img_front_biceps")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isCalvesShow {
                            Image("img_front_calves")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isChestShow {
                            Image("img_front_chest")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isForearmsShow {
                            Image("img_front_forearms")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isQuadricepsShow {
                            Image("img_front_quadriceps")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isShoulderShow {
                            Image("img_front_shoulder")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                    }
                    
                    ZStack {
                        Image("img_muscle_back_body")
                            .resizable()
                            .frame(width: 150, height: 320)
                            .scaledToFill()
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let location = value.location
                                    if isLeftBackCalvesRange(location: location) || isRightBackCalvesRange(location: location) {
                                        reviewViewModel.isBackCalvesShow = !reviewViewModel.isBackCalvesShow
                                    }
                                    
                                    if isLeftBackForearmsRange(location: location) || isRightBackForearmsRange(location: location) {
                                        reviewViewModel.isBackForearmsShow = !reviewViewModel.isBackForearmsShow
                                    }
                                    
                                    if isGlutesRange(location: location) {
                                        reviewViewModel.isGlutesShow = !reviewViewModel.isGlutesShow
                                    }
                                    
                                    if isLeftHamstringsRange(location: location) || isRightHamstringsRange(location: location) {
                                        reviewViewModel.isHamstringsShow = !reviewViewModel.isHamstringsShow
                                    }
                                    
                                    if isLeftLatRange(location: location) || isRightLatRange(location: location) {
                                        reviewViewModel.isLatShow = !reviewViewModel.isLatShow
                                    }
                                    
                                    if isTrapRange(location: location) {
                                        reviewViewModel.isTrapShow = !reviewViewModel.isTrapShow
                                    }
                                    
                                    if isLeftBackShoulderRange(location: location) || isRightBackShoulderRange(location: location) {
                                        reviewViewModel.isBackShoulderShow = !reviewViewModel.isBackShoulderShow
                                    }
                                    
                                    if isLeftTricepsRange(location: location) || isRightTricepsRange(location: location) {
                                        reviewViewModel.isTricepsShow = !reviewViewModel.isTricepsShow
                                    }
                                }
                            )
                        
                        if reviewViewModel.isBackCalvesShow {
                            Image("img_back_calves")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isBackForearmsShow {
                            Image("img_back_forearms")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isGlutesShow {
                            Image("img_back_glutes")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isHamstringsShow {
                            Image("img_back_hamstrings")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isLatShow {
                            Image("img_back_lat")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isBackShoulderShow {
                            Image("img_back_shoulder")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isTrapShow {
                            Image("img_back_trap")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                        
                        if reviewViewModel.isTricepsShow {
                            Image("img_back_triceps")
                                .resizable()
                                .frame(width: 150, height: 320)
                                .scaledToFill()
                                .allowsHitTesting(false)
                        }
                    }
                }
                
                TextField("운동 이름을 하나만 입력해 주세요.", text: $reviewViewModel.exerciseName)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 30)
                    .background(Color(uiColor: .clear))
                    .overlay(
                        HStack {
                            Image(systemName: "figure.strengthtraining.traditional")
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                            Spacer()
                        }
                            .frame(maxWidth: .infinity, alignment: .leading),
                        alignment: .leading
                    )
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                Button(action: {
                    reviewViewModel.reviewButtonClicked()
                    reviewViewModel.isGptSuccess = true
                }) {
                    Text("피드백 받기")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .foregroundColor(textColorForCurrentColorScheme())
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                
                if reviewViewModel.isGptSuccess {
                    VStack(spacing: 20, content: {
                        HStack {
                            Text("피드백 결과")
                                .padding(.leading, 20)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(reviewViewModel.result)
                            .lineLimit(nil)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.38, green: 0.93, blue: 0.84), lineWidth: 2)
                                    .padding(.horizontal, -10)
                                    .padding(.vertical, -10)
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                        
                        Text("")
                    })
                }
            }
        }.onTapGesture {hideKeyboard()}
            .onAppear {
                setColorScheme()
            }
    }
    
    private func setColorScheme() {
        colorScheme = UIApplication.shared.windows.first?.rootViewController?.traitCollection.userInterfaceStyle == .dark ? .dark : .light
    }
    
    private func textColorForCurrentColorScheme() -> Color {
        return colorScheme == .light ? .white : .black
    }
}

extension ReviewView {
    func isAbsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 75.66665649414062, y: 94.66666666666667),
            CGPoint(x: 75.0, y: 157.3333231608073),
            CGPoint(x: 61.0, y: 108.99999491373698),
            CGPoint(x: 89.66665649414062, y: 107.99999491373698)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftBicepsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 42.666656494140625, y: 91.3333231608073),
            CGPoint(x: 31.333328247070312, y: 104.66666666666667),
            CGPoint(x: 46.33332824707031, y: 104.99999491373698),
            CGPoint(x: 35.33332824707031, y: 110.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightBicepsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 108.66665649414062, y: 91.99999491373698),
            CGPoint(x: 115.33332824707031, y: 109.99999491373698),
            CGPoint(x: 119.33332824707031, y: 103.3333231608073),
            CGPoint(x: 104.33332824707031, y: 103.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftCalvesRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 58.33332824707031, y: 228.3333231608073),
            CGPoint(x: 57.33332824707031, y: 276.3333231608073),
            CGPoint(x: 47.33332824707031, y: 245.3333231608073),
            CGPoint(x: 67.33332824707031, y: 246.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightCalvesRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 92.33332824707031, y: 228.3333231608073),
            CGPoint(x: 84.0, y: 245.3333231608073),
            CGPoint(x: 102.66665649414062, y: 245.3333231608073),
            CGPoint(x: 96.66665649414062, y: 270.999994913737)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isChestRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 56.33332824707031, y: 64.66666666666667),
            CGPoint(x: 55.666656494140625, y: 90.66666666666667),
            CGPoint(x: 97.33332824707031, y: 64.99999491373698),
            CGPoint(x: 100.66665649414062, y: 89.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftForearmsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 29.0, y: 111.66666666666667),
            CGPoint(x: 26.666656494140625, y: 152.3333231608073),
            CGPoint(x: 40.0, y: 128.3333231608073),
            CGPoint(x: 24.0, y: 130.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightForearmsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 126.66665649414062, y: 149.66666666666669),
            CGPoint(x: 128.0, y: 127.66666666666667),
            CGPoint(x: 110.66665649414062, y: 128.999994913737),
            CGPoint(x: 118.33332824707031, y: 115.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftQuadricepsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 54.666656494140625, y: 151.3333231608073),
            CGPoint(x: 58.33332824707031, y: 221.66666666666669),
            CGPoint(x: 45.666656494140625, y: 178.999994913737),
            CGPoint(x: 72.33332824707031, y: 184.999994913737)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightQuadricepsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 95.66665649414062, y: 151.66666666666669),
            CGPoint(x: 94.0, y: 220.66666666666669),
            CGPoint(x: 79.33332824707031, y: 185.3333231608073),
            CGPoint(x: 105.0, y: 178.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftShoulderRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 49.666656494140625, y: 66.99999491373698),
            CGPoint(x: 34.0, y: 82.99999491373698),
            CGPoint(x: 46.33332824707031, y: 78.66666666666667),
            CGPoint(x: 36.666656494140625, y: 74.99999491373698)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightShoulderRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 116.0, y: 85.66666666666667),
            CGPoint(x: 102.0, y: 67.3333231608073),
            CGPoint(x: 102.33332824707031, y: 74.99999491373698),
            CGPoint(x: 117.33332824707031, y: 76.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftBackCalvesRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 59.666656494140625, y: 231.3333231608073),
            CGPoint(x: 59.666656494140625, y: 279.999994913737),
            CGPoint(x: 47.666656494140625, y: 247.66666666666669),
            CGPoint(x: 67.33332824707031, y: 243.66666666666669)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightBackCalvesRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 93.0, y: 231.3333231608073),
            CGPoint(x: 92.33332824707031, y: 280.3333231608073),
            CGPoint(x: 83.33332824707031, y: 244.999994913737),
            CGPoint(x: 103.33332824707031, y: 243.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftBackForearmsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 35.33332824707031, y: 117.3333231608073),
            CGPoint(x: 24.333328247070312, y: 149.3333231608073),
            CGPoint(x: 25.333328247070312, y: 119.66666666666667),
            CGPoint(x: 40.33332824707031, y: 125.99999491373698)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightBackForearmsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 118.33332824707031, y: 116.99999491373698),
            CGPoint(x: 126.33332824707031, y: 149.999994913737),
            CGPoint(x: 128.0, y: 120.66666666666667),
            CGPoint(x: 111.66665649414062, y: 126.99999491373698)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isGlutesRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 75.66665649414062, y: 142.66666666666669),
            CGPoint(x: 76.33332824707031, y: 171.999994913737),
            CGPoint(x: 51.33332824707031, y: 157.999994913737),
            CGPoint(x: 99.33332824707031, y: 159.66666666666669)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftHamstringsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 59.666656494140625, y: 176.66666666666669),
            CGPoint(x: 60.666656494140625, y: 225.66666666666669),
            CGPoint(x: 47.666656494140625, y: 199.3333231608073),
            CGPoint(x: 72.66665649414062, y: 190.999994913737)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightHamstringsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 92.33332824707031, y: 176.3333231608073),
            CGPoint(x: 92.33332824707031, y: 227.3333231608073),
            CGPoint(x: 80.66665649414062, y: 192.66666666666669),
            CGPoint(x: 104.0, y: 195.3333231608073)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftLatRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 74.33332824707031, y: 114.66666666666667),
            CGPoint(x: 50.33332824707031, y: 113.66666666666667),
            CGPoint(x: 60.33332824707031, y: 132.66666666666669),
            CGPoint(x: 56.33332824707031, y: 101.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightLatRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 78.33332824707031, y: 114.66666666666667),
            CGPoint(x: 102.33332824707031, y: 110.99999491373698),
            CGPoint(x: 91.66665649414062, y: 131.999994913737),
            CGPoint(x: 92.33332824707031, y: 101.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isTrapRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 75.33332824707031, y: 53.999994913736984),
            CGPoint(x: 57.666656494140625, y: 65.66666666666667),
            CGPoint(x: 94.66665649414062, y: 66.3333231608073),
            CGPoint(x: 75.66665649414062, y: 99.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftBackShoulderRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 46.33332824707031, y: 66.3333231608073),
            CGPoint(x: 39.666656494140625, y: 85.66666666666667),
            CGPoint(x: 50.666656494140625, y: 70.99999491373698),
            CGPoint(x: 36.666656494140625, y: 74.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightBackShoulderRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 99.33332824707031, y: 69.99999491373698),
            CGPoint(x: 106.0, y: 66.3333231608073),
            CGPoint(x: 111.66665649414062, y: 86.3333231608073),
            CGPoint(x: 117.0, y: 77.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isLeftTricepsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 43.666656494140625, y: 87.66666666666667),
            CGPoint(x: 36.666656494140625, y: 113.99999491373698),
            CGPoint(x: 28.666656494140625, y: 99.3333231608073),
            CGPoint(x: 47.33332824707031, y: 99.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
    
    func isRightTricepsRange(location: CGPoint) -> Bool {
        let points: [CGPoint] = [
            CGPoint(x: 108.66665649414062, y: 88.3333231608073),
            CGPoint(x: 104.66665649414062, y: 100.3333231608073),
            CGPoint(x: 122.33332824707031, y: 97.99999491373698),
            CGPoint(x: 117.33332824707031, y: 77.66666666666667)
        ]
        let maxX = points.max(by: { $0.x < $1.x })?.x ?? 0
        let maxY = points.max(by: { $0.y < $1.y })?.y ?? 0
        let minX = points.min(by: { $0.x < $1.x })?.x ?? 0
        let minY = points.min(by: { $0.y < $1.y })?.y ?? 0
        
        return (minX...maxX).contains(location.x) && (minY...maxY).contains(location.y)
    }
}

#Preview {
    ReviewView(reviewViewModel: ReviewViewModel(gptService: GPTService(gptRepository: GPTRepository())))
}
