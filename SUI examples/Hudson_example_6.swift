//
//  Hudson_example_6.swift
//  SUI examples
//
//  Created by Stanly Shiyanovskiy on 29.09.2022.
//

import Combine
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct Hudson_example_6: View {
    
    // ============================================
    /*
    @StateObject private var text = Debouncer(initValue: "", delay: 0.5)
    @StateObject private var slider = Debouncer(initValue: 0.0, delay: 0.1)
    
    var body: some View {
        VStack {
            TextField("Search for something", text: $text.input)
                .textFieldStyle(.roundedBorder)
            Text(text.output)
            
            Spacer()
                .frame(height: 50)
            
            Slider(value: $slider.input, in: 0...100)
            Text(slider.output.formatted())
        }
        .padding()
    }
    */
    // ============================================
    /*
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("Do Work Soon", action: viewModel.scheduleWork)
            Button("Do Work Now", action: viewModel.doWorkNow)
        }
        .padding()
    }
    */
    // ============================================
    /*
    @State private var context = CIContext()
    @State private var name = "Paul"
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Image(uiImage: generateQRCode(from: "\(name)"))
                .resizable()
                .interpolation(.none)
                .frame(width: 200, height: 200)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let output = filter.outputImage {
            if let cgImage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    */
    // ============================================
    /*
    var body: some View {
        TabView {
            ForEach(1..<6) { i in
                ExampleView3(number: i)
                    .tabItem {
                        Label(String(i), systemImage: "\(i).circle")
                    }
            }
        }
    }
    */
    // ============================================
    /*
    @StateObject private var viewModel = AutorefreshingObject()
    
    var body: some View {
        Self._printChanges()
        return Text("Example View Here")
            .background(.random)
    }
    */
    // ============================================
    
    @State private var counter = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("Example View Here")
            .onReceive(timer) { _ in
                counter += 1
            }
            .assert(counter < 50, "Timer exceeded")
    }
}

class Debouncer<T>: ObservableObject {
    @Published var input: T
    @Published var output: T
    
    private var textDebounce: AnyCancellable?
    
    init(initValue: T, delay: Double = 1) {
        self.input = initValue
        self.output = initValue
        
        textDebounce = $input
            .debounce(for: .seconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.output = $0
            }
    }
}

class ViewModel: ObservableObject {
    private var refreshTask: Task<Void, Error>?
    var workCounter = 0
    
    func doWorkNow() {
        workCounter += 1
        print("Work done: \(workCounter)")
    }
    
    func scheduleWork() {
        refreshTask?.cancel()
        
        refreshTask = Task {
            try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
            doWorkNow()
        }
    }
}

struct ExampleView3: View {
    let number: Int
    
    var body: some View {
        Text("View \(number)")
            .onFirstAppear {
                print("View \(number) appearing")
            }
    }
}

struct OnFirstAppearModifier: ViewModifier {
    @State private var hasLoaded = false
    var perform: () -> Void
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard hasLoaded == false else { return }
            hasLoaded = true
            perform()
        }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(perform: perform))
    }
}

class AutorefreshingObject: ObservableObject {
    var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.objectWillChange.send()
        }
    }
}

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension View {
    func debugPrint(_ value: @autoclosure () -> Any) -> some View {
        #if DEBUG
        print(value())
        #endif
        
        return self
    }
    
    func debugExecute(_ function: () -> Void) -> some View {
        #if DEBUG
        function()
        #endif
        
        return self
    }
    
    func debugExecute(_ function: (Self) -> Void) -> some View {
        #if DEBUG
        function(self)
        #endif
        
        return self
    }
}

extension View {
    public func assert(
        _ condition: @autoclosure () -> Bool,
        _ message: @autoclosure () -> String = String(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> some View {
        Swift.assert(condition(), message(), file: file, line: line)
        return self
    }
}

@main
struct MyApp: App {
    @State private var property = ExampleProperty(location: "App")
    
    var body: some Scene {
        print("In App.body")
        
        return WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
    
    init() {
        print("In App.init")
    }
}

struct ExampleProperty {
    init(location: String) {
        print("Creating ExampleProperty from \(location)")
    }
}

struct ExampleModifier: ViewModifier {
    init(location: String) {
        print("Creating ExampleModifier from \(location)")
    }

    func body(content: Content) -> some View {
        print("In ExampleModifier.body()")
        return content
    }
}

struct ContentView: View {
    @State private var property = ExampleProperty(location: "ContentView")
    
    var body: some View {
        print("In ContentView.body")
        
        return NavigationLink("Hello, world!") {
            DetailView()
        }
        .modifier(ExampleModifier(location: "ContentView"))
        .task { print("In first task") }
        .task { print("In second task") }
        .onAppear { print("In first onAppear") }
        .onAppear { print("In second onAppear") }
    }
    
    init() {
        print("In ContentView.init")
    }
}

struct DetailView: View {
    @State private var property = ExampleProperty(location: "DetailView")
    
    var body: some View {
        print("In DetailView.body")
        
        return Text("Hello, world!")
            .modifier(ExampleModifier(location: "DetailView"))
            .task { print("In detail task") }
            .onAppear { print("In detail onAppear") }
    }
    
    init() {
        print("In DetailView.init")
    }
}


struct Hudson_example_6_Previews: PreviewProvider {
    static var previews: some View {
        Hudson_example_6()
    }
}
