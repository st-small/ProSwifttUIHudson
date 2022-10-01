//
//  Hudson_example_5.swift
//  SUI examples
//
//  Created by Stanly Shiyanovskiy on 27.09.2022.
//

import SpriteKit
import SwiftUI

struct Hudson_example_5: View {
    
//    @State private var particleSystem = ParticleSystem()
//
//    var body: some View {
//        TimelineView(.animation) { timeline in
//            Canvas { ctx, size in
//                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
//                particleSystem.update(date: timelineDate)
//                ctx.blendMode = .plusLighter
//                ctx.addFilter(.blur(radius: 10))
//
//                for particle in particleSystem.particles {
//                    ctx.opacity = particle.deathDate - timelineDate
//                    ctx.fill(Circle().path(in: CGRect(x: particle.position.x - 16, y: particle.position.y - 16, width: 32, height: 32)), with: .color(.cyan))
//                }
//            }
//        }
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { drag in
//                    particleSystem.position = drag.location
//                }
//        )
//        .ignoresSafeArea()
//        .background(.black)
//    }
    
    // =================================================
    
//    @State private var particleSystem = ParticleSystem()
//
//    var body: some View {
//        LinearGradient(
//            colors: [.red, .indigo],
//            startPoint: .top,
//            endPoint: .bottom
//        ).mask {
//            TimelineView(.animation) { timeline in
//                Canvas { ctx, size in
//                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
//                    particleSystem.update(date: timelineDate, size: size)
//                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
//                    ctx.addFilter(.blur(radius: 10))
//
//                    ctx.drawLayer { ctx in
//                        for particle in particleSystem.particles {
//                            ctx.opacity = particle.deathDate - timelineDate
//                            ctx.fill(
//                                Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 32, height: 32)),
//                                with: .color(.white)
//                            )
//                        }
//                    }
//                }
//            }
//        }
//        .ignoresSafeArea()
//        .background(.black)
//    }
    
    // =================================================
    
//    @State private var particleSystem = ParticleSystem(count: 15)
//    @State private var threshold = 0.5
//    @State private var blur = 30.0
//
//    var body: some View {
//        VStack {
//            LinearGradient(
//                colors: [.red, .orange],
//                startPoint: .top,
//                endPoint: .bottom
//            ).mask {
//                TimelineView(.animation) { timeline in
//                    Canvas { ctx, size in
//                        particleSystem.update(date: timeline.date.timeIntervalSinceReferenceDate)
//                        ctx.addFilter(.alphaThreshold(min: threshold))
//                        ctx.addFilter(.blur(radius: blur))
//                        ctx.drawLayer { ctx in
//                            for particle in particleSystem.particles {
//                                guard let shape = ctx.resolveSymbol(id: particle.id) else { continue }
//                                ctx.draw(shape, at: CGPoint(x: particle.x * size.width, y: particle.y * size.height))
//                            }
//                        }
//                    } symbols: {
//                        ForEach(particleSystem.particles) { particle in
//                            AnimationPolygon()
//                                .frame(width: particle.size, height: particle.size)
//                        }
//                    }
//                }
//            }
//            .ignoresSafeArea()
//            .background(.indigo)
//
//            LabeledContent("Threshold") {
//                Slider(value: $threshold, in: 0.01...0.99)
//            }
//            .padding(.horizontal)
//
//            LabeledContent("Blur") {
//                Slider(value: $blur, in: 0...40)
//            }
//            .padding(.horizontal)
//        }
//    }
    
    // =================================================
    
//    var body: some View {
//        ZStack {
//            ForEach(0..<15) { _ in
//                BackgroundBlob()
//            }
//        }
//        .background(.blue)
//    }
    
    // =================================================
    
    @State private var text = "Hello"
    @State private var speed = 0.5
    @State private var strength = 0.5
    @State private var frequency = 5.0
    
    var body: some View {
        VStack {
            WaterEffect(speed: speed, strength: strength, frequency: frequency) {
                Circle()
                    .fill(.red)
                    .frame(width: 150, height: 150)
                    .padding()
                    .overlay(Circle().stroke(.red, lineWidth: 4))
                    .overlay(Text(text).font(.title).foregroundColor(.white))
                    .padding()
            }
            
            TextField("Enter a message", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            LabeledContent("Speed") {
                Slider(value: $speed)
            }
            
            LabeledContent("Strength") {
                Slider(value: $strength)
            }
            
            LabeledContent("Frequency") {
                Slider(value: $frequency, in: 5...25)
            }
        }
        .padding()
    }
}

/*
struct Particle {
    let position: CGPoint
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 1
}

class ParticleSystem {
    var particles = [Particle]()
    var position = CGPoint.zero

    func update(date: TimeInterval) {
        particles = particles.filter { $0.deathDate > date }
        particles.append(Particle(position: position))
    }
}
*/

/*
class Particle {
    var x: Double
    var y: Double
    let xSpeed: Double
    let ySpeed: Double
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 2
    
    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}

class ParticleSystem {
    var particles = [Particle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate

    func update(date: TimeInterval, size: CGSize) {
        let delta = date - lastUpdate
        lastUpdate = date
        
        for (index, particle) in particles.enumerated() {
            if particle.deathDate < date {
                particles.remove(at: index)
            } else {
                particle.x += particle.xSpeed * delta
                particle.y += particle.ySpeed * delta
            }
        }
        
        let newParticle = Particle(x: .random(in: -32...size.width), y: -32, xSpeed: .random(in: -50...50), ySpeed: .random(in: 100...500))
        particles.append(newParticle)
    }
}
*/

/*
class Particle: Identifiable {
    let id = UUID()
    var size = Double.random(in: 100...250)
    var x = Double.random(in: -0.1...1.1)
    var y = Double.random(in: -0.25...1.25)
    var isMovingDown = Bool.random()
    var speed = Double.random(in: 0.01...0.1)
}

class ParticleSystem {
    var particles = [Particle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    init(count: Int) {
        particles = (0..<count).map { _ in Particle() }
    }

    func update(date: TimeInterval) {
        let delta = date - lastUpdate
        lastUpdate = date
        
        for particle in particles {
            if particle.isMovingDown {
                particle.y += particle.speed * delta
                
                if particle.y > 1.25 {
                    particle.isMovingDown = false
                }
            } else {
                particle.y -= particle.speed * delta
                
                if particle.y < -0.25 {
                    particle.isMovingDown = true
                }
            }
        }
    }
}

extension Array: VectorArithmetic, AdditiveArithmetic where Element == Double {
    
    public static var zero = [0.0]
    
    public var magnitudeSquared: Double { 0 }
    
    public static func +=(lhs: inout [Double], rhs: [Double]) {
        for (index, item) in rhs.enumerated() {
            lhs[index] += item
        }
    }
    
    public static func -=(lhs: inout [Double], rhs: [Double]) {
        for (index, item) in rhs.enumerated() {
            lhs[index] -= item
        }
    }
    
    public mutating func scale(by rhs: Double) {
        for (index, item) in self.enumerated() {
            self[index] = item * rhs
        }
    }
    
    public static func -(lhs: [Double], rhs: [Double]) -> [Double] { [] }
}

struct AnimatablePolygonShape: Shape {
    
    var animatableData: [Double]
    
    init(points: [Double]) {
        self.animatableData = points
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = min(center.x, center.y)
            
            let lines = animatableData.enumerated().map { index, value in
                let fraction = Double(index) / Double(animatableData.count)
                let xPos = center.x + radius * cos(fraction * .pi * 2)
                let yPos = center.y + radius * sin(fraction * .pi * 2)
                return CGPoint(x: xPos * value, y: yPos * value)
            }
            
            path.addLines(lines)
        }
    }
}

struct AnimationPolygon: View {
    @State private var points = Self.makePoints()
    @State private var timer = Timer.publish(every: 1, tolerance: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        AnimatablePolygonShape(points: points)
            .animation(.easeInOut(duration: 3), value: points)
            .onReceive(timer) { date in
                points = Self.makePoints()
            }
    }
    
    static func makePoints() -> [Double] {
        (0..<8).map { _ in .random(in: 0.8...1.2) }
    }
}
*/

/*
struct BackgroundBlob: View {
    
    @State private var rotationAmount = 0.0
    let alignment: Alignment = [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing].randomElement()!
    let color: Color = [.blue, .blue, .blue, .cyan, .indigo, .mint, .orange, .pink, .purple, .red, .teal, .yellow].randomElement()!
    
    var body: some View {
        Ellipse()
            .fill(color)
            .frame(width: .random(in: 200...500), height: .random(in: 200...500))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .offset(x: .random(in: -400...400), y: .random(in: -400...400))
            .rotationEffect(.degrees(rotationAmount))
            .animation(.linear(duration: .random(in: 2...4)).repeatForever(), value: rotationAmount)
            .onAppear {
                rotationAmount = .random(in: -360...360)
            }
            .blur(radius: 75)
    }
}
*/

class WaterScene: SKScene {
    private let spriteNode = SKSpriteNode()
    var image: UIImage?
    let waterShader = SKShader(source: """
    void main() {
        float speed = u_time * u_speed;
    
        v_tex_coord.x += cos((v_tex_coord.x + speed) * u_frequency) * u_strength;
        v_tex_coord.y += sin((v_tex_coord.y + speed) * u_frequency) * u_strength;
    
        gl_FragColor = texture2D(u_texture, v_tex_coord);
    }
    """)
    
    override func sceneDidLoad() {
        backgroundColor = .clear
        scaleMode = .resizeFill
        
        spriteNode.shader = waterShader
        addChild(spriteNode)
    }
    
    func updateTexture() {
        guard view != nil else { return }
        guard let image else { return }
        
        let texture = SKTexture(image: image)
        spriteNode.texture = texture
        spriteNode.size = texture.size()
        spriteNode.position.x = frame.midX
        spriteNode.position.y = frame.midY
    }
    
    override func didMove(to view: SKView) {
        updateTexture()
    }
}

struct WaterEffect<Content: View>: View {
    
    @Environment(\.displayScale) var displayScale
    @State private var scene = WaterScene()
    
    var speed: Double
    var strength: Double
    var frequency: Double
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        let renderer = ImageRenderer(content: content())
        renderer.scale = displayScale
        
        let image = renderer.uiImage
        let size = image?.size ?? .zero
        
        scene.waterShader.uniforms = [
            SKUniform(name: "u_speed", float: Float(speed)),
            SKUniform(name: "u_strength", float: Float(strength) / 20.0),
            SKUniform(name: "u_frequency", float: Float(frequency))
        ]
        
        scene.image = image
        scene.updateTexture()
        
        return SpriteView(scene: scene, options: .allowsTransparency)
            .frame(width: size.width, height: size.height)
    }
}


struct Hudson_example_5_Previews: PreviewProvider {
    static var previews: some View {
        Hudson_example_5()
    }
}
