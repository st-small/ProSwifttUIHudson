//
//  Hudson_example_4.swift
//  SUI examples
//
//  Created by Stanly Shiyanovskiy on 24.09.2022.
//

import SwiftUI

struct Hudson_example_4: View {
    
//    let layouts = [
//        AnyLayout(VStackLayout()),
//        AnyLayout(HStackLayout()),
//        AnyLayout(ZStackLayout()),
//        AnyLayout(GridLayout())
//    ]
//    @State private var currentLayout = 0
//
//    var layout: AnyLayout {
//        layouts[currentLayout]
//    }
//
//
//    var body: some View {
//        VStack {
//            Spacer()
//
//            layout {
//
//                GridRow {
//                    ExampleView2(color: .red)
//                    ExampleView2(color: .green)
//                }
//
//                GridRow {
//                    ExampleView2(color: .blue)
//                    ExampleView2(color: .orange)
//                }
//            }
//
//            Spacer()
//
//            Button("Change Layout") {
//                withAnimation {
//                    currentLayout += 1
//
//                    if currentLayout == layouts.count {
//                        currentLayout = 0
//                    }
//                }
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.gray)
//    }
    
    // =====================================================
    
//    @State private var count = 16
//
//    var body: some View {
//        RadialLayout {
//            ForEach(0..<count, id: \.self) { _ in
//                Rectangle()
//                    .frame(width: 32, height: 32)
//            }
//        }
//        .safeAreaInset(edge: .bottom) {
//            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
//                .padding()
//        }
//    }
    
    // =====================================================
    
//    var body: some View {
//        EqualWidthHStack {
//            Text("Short")
//                .background(.red)
//
//            Text("This is long")
//                .background(.green)
//
//            Text("This is longest")
//                .background(.blue)
//        }
//    }
    
    // =====================================================
    
//    var body: some View {
//        RelativeHStack(spacing: 50) {
//            Text("First")
//                .frame(maxWidth: .infinity)
//                .background(.red)
//                .layoutPriority(1)
//
//            Text("Second")
//                .frame(maxWidth: .infinity)
//                .background(.green)
//                .layoutPriority(2)
//
//            Text("Third")
//                .frame(maxWidth: .infinity)
//                .background(.blue)
//                .layoutPriority(3)
//        }
//    }
    
    // =====================================================
    
//    @State private var columns = 3
//
//    @State private var views = (0..<20).map { _ in
//        CGSize(width: .random(in: 100...500), height: .random(in: 100...500))
//    }
//
//    var body: some View {
//        ScrollView {
//            MasonryLayout(columns: columns) {
//                ForEach(0..<20) { i in
//                    if i.isMultiple(of: 2) {
//                        PlaceholderView(size: views[i])
//                    } else {
//                        Divider()
//                    }
//                }
//            }
//            .padding(.horizontal, 5)
//        }
//        .safeAreaInset(edge: .bottom) {
//            Stepper("Columns: \(columns)", value: $columns.animation(), in: 1...5)
//                .padding()
//                .background(.regularMaterial)
//        }
//    }
    
    // =====================================================
    
    @State private var count = 16
    @State private var isExpanded = false
    
    var body: some View {
        RadialLayout(rollOut: isExpanded ? 1 : 0) {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .frame(width: 32, height: 32)
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack {
                Stepper("Count \(count)", value: $count.animation(), in: 0...36)
                    .padding()
                
                Button("Expand") {
                    withAnimation(.easeInOut(duration: 1)) {
                        isExpanded.toggle()
                    }
                }
            }
        }
    }
}

struct ExampleView2: View {
    
    @State private var counter = 0
    let color: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .overlay(
                    Text(String(counter))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                )
        }
        .frame(width: 100, height: 100)
        .rotationEffect(.degrees(.random(in: -20...20)))
    }
}

struct RadialLayout: Layout {
    var rollOut = 0.0
    
    var animatableData: Double {
        get { rollOut }
        set { rollOut = newValue }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        print("In sizeThatFits")
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        print("In placeSubviews")
        let radius = min(bounds.size.width, bounds.size.height) / 2
        let angle = Angle.degrees(360 / Double(subviews.count)).radians * rollOut
        
        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)
            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
            let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct EqualWidthHStack: Layout {
    
    private func maximumSize(across subviews: Subviews) -> CGSize {
//        var maximumSize = CGSize.zero
//
//        for view in subviews {
//            let size = view.sizeThatFits(.unspecified)
//
//            if size.width > maximumSize.width {
//                maximumSize.width = size.width
//            }
//
//            if size.height > maximumSize.height {
//                maximumSize.height = size.height
//            }
//        }
//
//        return maximumSize
        
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return sizes.reduce(.zero) { largest, next in
            CGSize(width: max(largest.width, next.width), height: max(largest.height, next.height))
        }
    }
    
    private func spacing(for subviews: Subviews) -> [Double] {
//        var spacing = [Double]()
//
//        for index in subviews.indices {
//            if index == subviews.count - 1 {
//                spacing.append(0)
//            } else {
//                let distance = subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
//                spacing.append(distance)
//            }
//        }
//
//        return spacing
        
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
        }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maximumSize(across: subviews)
        let spacing = spacing(for: subviews)
        let totalSpacing = spacing.reduce(0, +)
        
        return CGSize(
            width: maxSize.width * Double(subviews.count) + totalSpacing,
            height: maxSize.height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maximumSize(across: subviews)
        let spacing = spacing(for: subviews)
        
        let proposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var x = bounds.minX + maxSize.width / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY), anchor: .center, proposal: proposal)
            x += maxSize.width + spacing[index]
        }
    }
}

struct RelativeHStack: Layout {
    var spacing = 0.0
    
    func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
        let totalSpacing = spacing * Double(subviews.count - 1)
        let availableWidth = totalWidth - totalSpacing
        let totalPriorities = subviews.reduce(0) { $0 + $1.priority }
        
        var viewFrames = [CGRect]()
        var x = 0.0
        
        for subview in subviews {
            let subviewWidth = availableWidth * subview.priority / totalPriorities
            let proposal = ProposedViewSize(width: subviewWidth, height: nil)
            let size = subview.sizeThatFits(proposal)
            let frame = CGRect(x: x, y: 0, width: size.width, height: size.height)
            viewFrames.append(frame)
            
            x += size.width + spacing
        }
        
        return viewFrames
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for: subviews, in: width)
        let height = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        
        return CGSize(width: width, height: height.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frames(for: subviews, in: bounds.width)
        
        for index in subviews.indices {
            let frame = viewFrames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.midY)
            subviews[index].place(at: position, anchor: .leading, proposal: ProposedViewSize(frame.size))
        }
    }
}

struct MasonryLayout: Layout {
    var columns: Int
    var spacing: Double
    
    struct Cache {
        var frames: [CGRect]
        var width = 0.0
    }
    
    static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        return properties
    }
    
    init(columns: Int = 3, spacing: Double = 5) {
        self.columns = max(1, columns)
        self.spacing = spacing
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache(frames: [])
    }
    
    func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
        print("Recreating cache")
        let totalSpacing = spacing * Double(columns - 1)
        let columnWidth = (totalWidth - totalSpacing) / Double(columns)
        let columnWidthWithSpacing = columnWidth + spacing
        let proposedSize = ProposedViewSize(width: columnWidth, height: nil)
        
        var viewFrames = [CGRect]()
        var columnHeights = Array(repeating: 0.0, count: columns)
        
        for subview in subviews {
            var selectedColumn = 0
            var selectedHeight = Double.greatestFiniteMagnitude
            
            for (columnIndex, height) in columnHeights.enumerated() {
                if height < selectedHeight {
                    selectedColumn = columnIndex
                    selectedHeight = height
                }
            }
            
            let x = Double(selectedColumn) * columnWidthWithSpacing
            let y = columnHeights[selectedColumn]
            let size = subview.sizeThatFits(proposedSize)
            let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            columnHeights[selectedColumn] += size.height + spacing
            viewFrames.append(frame)
        }
        
        return viewFrames
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for: subviews, in: width)
        let height = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        
        cache.frames = viewFrames
        cache.width = width
        
        return CGSize(width: width, height: height.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        
        if cache.width != bounds.width {
            cache.frames = frames(for: subviews, in: bounds.width)
            cache.width = bounds.width
        }
        
        for index in subviews.indices {
            let frame = cache.frames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY)
            subviews[index].place(at: position, proposal: ProposedViewSize(frame.size))
        }
    }
}

struct PlaceholderView: View {
    let color: Color = [.blue, .cyan, .green, .indigo, .mint, .orange, .pink, .purple, .red].randomElement()!
    let size: CGSize
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            
            Text("\(Int(size.width))x\(Int(size.height))")
                .foregroundColor(.white)
                .font(.headline)
        }
        .aspectRatio(size, contentMode: .fill)
    }
}





struct Hudson_example_4_Previews: PreviewProvider {
    static var previews: some View {
        Hudson_example_4()
    }
}
