//
//  Hudson_example_2.swift
//  SUI examples
//
//  Created by Stanly Shiyanovskiy on 22.09.2022.
//

import SwiftUI

struct Hudson_example_2: View {
    
//    @State private var redAtFront = false
//    let colors: [Color] = [.blue, .green, .orange, .purple, .mint]
//
//    var body: some View {
//        VStack {
//            Button("Toggle zIndex") {
//                withAnimation(.linear(duration: 1)) {
//                    redAtFront.toggle()
//                }
//            }
//
//            ZStack {
//                RoundedRectangle(cornerRadius: 25)
//                    .fill(.red)
//                    .animatableZIndex(redAtFront ? 6 : 0)
//
//                ForEach(0..<5) { i in
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(colors[i])
//                        .offset(
//                            x: Double(i + 1) * 20,
//                            y: Double(i + 1) * 20
//                        )
//                        .zIndex(Double(i))
//                }
//            }
//            .frame(width: 200, height: 200)
//        }
//    }
    
    // =====================================================
    
//    @State private var scaleUp = false
//
//    var body: some View {
//        Text("Hello, World!")
//            .animatableFont(size: scaleUp ? 56 : 24)
//            .onTapGesture {
//                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
//                    scaleUp.toggle()
//                }
//            }
//    }
    
    // =====================================================
    
//    @State private var isRed = false
//
//    var body: some View {
//        Text("Hello, World!")
////            .foregroundColor(.white)
////            .colorMultiply(isRed ? .red : .blue)
//            .animatableForegroundColor(isRed ? .red : .blue)
//            .font(.largeTitle.bold())
//            .onTapGesture {
//                withAnimation {
//                    isRed.toggle()
//                }
//            }
//    }
    
    // =====================================================
    
//    @State private var value = 0.0
//
//    var body: some View {
//        CountingText(value: value)
//            .onTapGesture {
//                withAnimation(.linear) {
//                    value = Double.random(in: 1...1000)
//                }
//            }
//    }
    
    // =====================================================
    
//    @State private var value = 0
//    let message = "This is a very long piece of text that appears letter by letter."
//
//    var body: some View {
//        VStack {
//            TypewriterText(string: message, count: value)
//                .frame(width: 300, alignment: .leading)
//
//            Button("Type!") {
//                withAnimation(.linear(duration: 2)) {
//                    value = message.count
//                }
//            }
//
//            Button("Reset") {
//                value = 0
//            }
//        }
//    }
    
    // =====================================================
    
//    @State private var offset = -200.0
//
//    var body: some View {
//        Text("Hello, World!")
//            .offset(y: offset)
//            .animation(
////                .edgeBounce(duration: 2)
////                .easeInOutBack(duration: 2)
//                .easeInOutBackSteep(duration: 2)
//                .repeatForever(autoreverses: true),
//                value: offset
//            )
//            .onTapGesture {
//                offset = 200
//            }
//    }
    
    // =====================================================
    
//    @State private var useRedFill = false
//
//    var body: some View {
//        VStack {
//            CircleGrid(useRedFill: useRedFill)
//
//            Spacer()
//
//            Button("Toggle Color") {
//                withAnimation(.easeInOut) {
//                    useRedFill.toggle()
//                }
//            }
//        }
//    }
    
    // =====================================================
    
    @State private var isFavorite = false
    
    var body: some View {
        VStack(spacing: 60) {
            ForEach([Font.body, Font.largeTitle, Font.system(size: 72)], id: \.self) { font in
                Button {
                    isFavorite.toggle()
                } label: {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .transition(
                                .confetti(
                                    color: .angularGradient(
                                        colors: [.red, .yellow, .green, .blue, .purple, .red],
                                        center: .center,
                                        startAngle: .zero,
                                        endAngle: .degrees(360)),
                                    size: 3
                                )
                            )
                    } else {
                        Image(systemName: "heart")
                            .foregroundStyle(.gray)
                    }
                }
                .font(font)
            }
        }
    }
}

struct AnimatableZIndexModifier: ViewModifier, Animatable {
    var index: Double
    
    var animatableData: Double {
        get { index }
        set { print(newValue); index = newValue }
    }
    
    func body(content: Content) -> some View {
        content.zIndex(index)
    }
}

extension View {
    func animatableZIndex(_ index: Double) -> some View {
        modifier(AnimatableZIndexModifier(index: index))
    }
}

struct AnimatableFontModifier: ViewModifier, Animatable {
    var size: Double
    
    var animatableData: Double {
        get { size }
        set{ size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableFont(size: Double) -> some View {
        modifier(AnimatableFontModifier(size: size))
    }
}

extension View {
    func animatableForegroundColor(_ color: Color) -> some View {
        self
            .foregroundColor(.white)
            .colorMultiply(color)
    }
}

struct CountingText: View, Animatable {
    var value: Double
    var fractionLength = 8
    
    var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    
    var body: some View {
        Text(value
            .formatted(.number
                .precision(.fractionLength(fractionLength))
            )
        )
    }
}

struct TypewriterText: View, Animatable {
    var string: String
    var count = 0
    
    var animatableData: Double {
        get { Double(count) }
        set { count = Int(max(0, newValue)) }
    }
    
    var body: some View {
        let stringToShow = String(string.prefix(count))
        ZStack {
            Text(string)
                .hidden()
                .overlay(
                    Text(stringToShow),
                    alignment: .topLeading
                )
        }
    }
}

extension Animation {
    static var edgeBounce: Animation {
        Animation.timingCurve(0, 1, 1, 0)
    }
    
    static func edgeBounce(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0, 1, 1, 0, duration: duration)
    }
}

extension Animation {
    static var easeInOutBack: Animation {
        Animation.timingCurve(0.5, -0.5, 0.5, 1.5)
    }
    
    static func easeInOutBack(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.5, -0.5, 0.5, 1.5, duration: duration)
    }
    
    static var easeInOutBackSteep: Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5)
    }
    
    static func easeInOutBackSteep(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5, duration: duration)
    }
}

struct CircleGrid: View {
    var useRedFill = false
    
    var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 64))]) {
            ForEach(0..<30) { i in
                Circle()
                    .fill(useRedFill ? .red : .blue)
                    .frame(height: 64)
                    .transaction { transaction in
                        transaction.animation = transaction.animation?.delay(Double(i) / 100)
                    }
            }
        }
    }
}

struct ConfettiModifier<T: ShapeStyle>: ViewModifier {
    
    @State private var circleSize = 0.00001
    @State private var strokeMultiplier = 1.0
    
    @State private var confettiIsHidden = true
    @State private var confettiMovement = 0.7
    @State private var confettiScale = 1.0
    
    @State private var contentsScale = 0.00001
    
    private let speed = 0.3
    
    var color: T
    var size: Double
    
    func body(content: Content) -> some View {
        content
            .hidden()
            .padding(10)
            .overlay(
                ZStack {
                    GeometryReader { proxy in
                        Circle()
                            .strokeBorder(color, lineWidth: proxy.size.width / 2 * strokeMultiplier)
                            .scaleEffect(circleSize)
                        
                        ForEach(0..<15) { i in
                            Circle()
                                .fill(color)
                                .frame(
                                    width: size + sin(Double(i)),
                                    height: size + sin(Double(i))
                                )
                                .scaleEffect(confettiScale)
                                .offset(x: proxy.size.width / 2 * confettiMovement)
                                .offset(x: proxy.size.width / 2 * confettiMovement + (i.isMultiple(of: 2) ? size : 0))
                                .rotationEffect(.degrees(24 * Double(i)))
                                .offset(x: (proxy.size.width - size) / 2, y: (proxy.size.height - size) / 2)
                                .opacity(confettiIsHidden ? 0 : 1)
                        }
                    }
                    
                    content
                        .scaleEffect(contentsScale)
                }
            )
            .padding(-10)
            .onAppear {
                withAnimation(.easeIn(duration: speed)) {
                    circleSize = 1
                }
                withAnimation(.easeOut(duration: speed).delay(speed)) {
                    strokeMultiplier = 0.00001
                }
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5).delay(speed)) {
                    contentsScale = 1
                }
                withAnimation(.easeOut(duration: speed).delay(speed * 1.25)) {
                    confettiIsHidden = false
                    confettiMovement = 1.2
                }
                withAnimation(.easeOut(duration: speed).delay(speed * 2)) {
                    confettiScale = 0.00001
                }
            }
    }
}

extension AnyTransition {
    static var confetti: AnyTransition {
        .modifier(
            active: ConfettiModifier(color: .blue, size: 3),
            identity: ConfettiModifier(color: .blue, size: 3)
        )
    }
    
    static func confetti<T: ShapeStyle>(color: T = .blue, size: Double = 0.3) -> AnyTransition {
        AnyTransition.modifier(
            active: ConfettiModifier(color: color, size: size),
            identity: ConfettiModifier(color: color, size: size)
        )
    }
}

struct Hudson_example_2_Previews: PreviewProvider {
    static var previews: some View {
        Hudson_example_2()
    }
}
