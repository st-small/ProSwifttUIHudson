//
//  Hudson_example_3.swift
//  SUI examples
//
//  Created by Stanly Shiyanovskiy on 23.09.2022.
//

import SwiftUI

struct Hudson_example_3: View {
    //    var body: some View {
    //        Text("Tap")
    //            .font(.title)
    //            .foregroundColor(.red)
    //            .bold()
    //            .fontWeight(.black)
    //            .onTapGesture {
    //                print(type(of: self.body))
    //            }
    
    //        VStack {
    //            Text("Tap")
    //        }
    //        .font(.title)
    //        .onTapGesture {
    //            print(type(of: self.body))
    //        }
    //    }
    
    // =====================================================
    
    //    @State private var firstName = ""
    //    @State private var lastName = ""
    //
    //    @State private var makeRequired = false
    //
    //    var body: some View {
    //        Form {
    //            RequirableTextField(title: "First name", text: $firstName)
    //            RequirableTextField(title: "Last name", text: $lastName)
    //            Toggle("Make required", isOn: $makeRequired.animation())
    //        }
    //        .required(makeRequired)
    //    }
    
    // =====================================================
    
    //    @State private var sliderValue = 1.0
    //    @State private var titleFont = Font.largeTitle
    //    @StateObject private var theme = ThemeManager()
    //
    //    var body: some View {
    //        VStack {
    //            CirclesView()
    //            Text("Hello, World!")
    //                .font(theme.titleFont)
    //
    //            Slider(value: $theme.strokeWidth, in: 1...10)
    //
    //            Button("Default font") {
    //                theme.titleFont = .largeTitle
    //            }
    //
    //            Button("Custom font") {
    //                theme.titleFont = TitleFontKey.defaultValue
    //            }
    //        }
    ////        .environment(\.strokeWidth, sliderValue)
    ////        .environment(\.titleFont, titleFont)
    //        .environmentObject(theme)
    //}
    
    // =====================================================
    
//    var body: some View {
//        WelcomeView()
//            .font(.largeTitle)
//    }
    
    // =====================================================
    
//    @State private var width = 0.0
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                SizingView()
//
//                Text("100%")
//                    .frame(width: width)
//                    .background(.red)
//
//                Text("150%")
//                    .frame(width: width * 1.5)
//                    .background(.green)
//
//                Text("200%")
//                    .frame(width: width * 2)
//                    .background(.blue)
//            }
//            .onPreferenceChange(WidthPreferenceKey.self) { width = $0 }
//            .navigationTitle("Width = \(width)")
//        }
//    }
    
    // =====================================================
    
    @State private var selectedCategory: Category?
    
    let categories = [
        Category(id: "Arctic", symbol: "snowflake"),
        Category(id: "Beach", symbol: "beach.umbrella"),
        Category(id: "Shared Homes", symbol: "house")
    ]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    CategoryButton(category: category, selection: $selectedCategory)
                }
            }
            
            List(categories) { category in
                HStack {
                    Button(category.id) {
                        withAnimation {
                            selectedCategory = category
                        }
                    }
                    
                    if selectedCategory == category {
                        Spacer()
                        
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            if let selectedCategory {
                Text("Selected: \(selectedCategory.id)")
            }
        }
        .overlayPreferenceValue(CategoryPreferenceKey.self) { preferences in
            GeometryReader { proxy in
                if let selected = preferences.first(where: { $0.category == selectedCategory }) {
                    let frame = proxy[selected.anchor]
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: frame.width, height: 2)
                        .position(x: frame.midX, y: frame.maxY)
                }
            }
        }
    }
}

struct FormElementIsRequiredKey: EnvironmentKey {
    static var defaultValue = false
}

extension EnvironmentValues {
    var required: Bool {
        get { self[FormElementIsRequiredKey.self] }
        set { self[FormElementIsRequiredKey.self] = newValue }
    }
}

extension View {
    func required(_ makeRequired: Bool = true) -> some View {
        environment(\.required, makeRequired)
    }
}

struct RequirableTextField: View {
    
    @Environment(\.required) var required
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(title, text: $text)
            
            if required {
                Image(systemName: "asterisk")
                    .imageScale(.small)
                    .foregroundColor(.red)
            }
        }
    }
}

struct StrokeWidthKey: EnvironmentKey {
    static var defaultValue = 1.0
}

extension EnvironmentValues {
    var strokeWidth: Double {
        get { self[StrokeWidthKey.self] }
        set { self[StrokeWidthKey.self] = newValue }
    }
}

extension View {
    func strokeWidth(_ width: Double) -> some View {
        environment(\.strokeWidth, width)
    }
}

struct CirclesView: View {
    
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        print("In CirclesView.body")
        
        return ForEach(0..<3) { _ in
            Circle()
                .stroke(.red, lineWidth: theme.strokeWidth)
        }
    }
}

struct TitleFontKey: EnvironmentKey {
    static var defaultValue = Font.custom("Georgia", size: 34)
}

extension EnvironmentValues {
    var titleFont: Font {
        get { self[TitleFontKey.self] }
        set { self[TitleFontKey.self] = newValue }
    }
}

extension View {
    func titleFont(_ font: Font) -> some View {
        environment(\.titleFont, font)
    }
}

class ThemeManager: ObservableObject {
    @Published var strokeWidth = 1.0
    @Published var titleFont = TitleFontKey.defaultValue
}

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "sun.max")
                    .navigationTitle("Image")
                    .transformEnvironment(\.font) { font in
                        font = font?.weight(.black)
                    }
                Text("Welcome!")
                    .navigationTitle("Text")
            }
            .navigationTitle("VStack")
        }
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue = 0.0
    
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct SizingView: View {
    
    @State private var width = 55.0
    
    var body: some View {
        Color.red
            .frame(width: width, height: 100)
            .onTapGesture {
                width = Double.random(in: 50...160)
            }
            .preference(key: WidthPreferenceKey.self, value: width)
    }
}

struct Category: Identifiable, Equatable {
    let id: String
    let symbol: String
}

struct CategoryPreference: Equatable {
    let category: Category
    let anchor: Anchor<CGRect>
}

struct CategoryPreferenceKey: PreferenceKey {
    static let defaultValue = [CategoryPreference]()
    
    static func reduce(value: inout [CategoryPreference], nextValue: () -> [CategoryPreference]) {
        value.append(contentsOf: nextValue())
    }
}

struct CategoryButton: View {
    var category: Category
    @Binding var selection: Category?
    
    var body: some View {
        Button {
            withAnimation {
                selection = category
            }
        } label: {
            VStack {
                Image(systemName: category.symbol)
                Text(category.id)
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(category.id)
        .anchorPreference(key: CategoryPreferenceKey.self, value: .bounds, transform: { [CategoryPreference(category: category, anchor: $0)] })
    }
}

struct Hudson_example_3_Previews: PreviewProvider {
    static var previews: some View {
        Hudson_example_3()
    }
}
