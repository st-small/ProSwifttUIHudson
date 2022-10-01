//
//  Hudson_example_1.swift
//  SUI examples
//
//  Created by Stanly Shiyanovskiy on 21.09.2022.
//

import SwiftUI

struct Hudson_example_1: View {
    
    @State private var usesFixedSize = false
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .fixedSize()
//            .frame(width: 30, height: 100)
        
        
        
//        HStack {
//            Text("Forecast")
//                .padding()
//                .frame(maxHeight: .infinity)
//                .background(.yellow)
//            Text("The rain in Spain falls mainly on the Spaniards")
//                .padding()
//                .frame(maxHeight: .infinity)
//                .background(.cyan)
//        }
//        .fixedSize(horizontal: false, vertical: true)
        
//        VStack {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .frame(width: usesFixedSize ? 300 : nil)
//                .background(.red)
//
//            Toggle("Fixed sizes", isOn: $usesFixedSize.animation())
//                .padding()
//        }
        
//        ScrollView {
//            Color.red
//                .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: nil, idealHeight: 400, maxHeight: 400)
//                .background(.blue)
//        }
        
//        Text("Hello, World!")
//            .frame(width: 200, height: 200)
//            .background(.blue)
//            .frame(width: 300, height: 300)
//            .background(.red)
//            .foregroundColor(.white)
        
//        VStack {
//            Text("Hello")
//            Text("World")
//            Text("1")
//        }
//        .onTapGesture {
//            print(type(of: self.body))
//        }
        
        VStack {
            if Bool.random() {
                Text("Hello")
            } else {
                Text("Goodbye")
            }
        }
        .onTapGesture {
            print(type(of: self.body))
        }
    }
}

struct Hudson_example_1_Previews: PreviewProvider {
    static var previews: some View {
        Hudson_example_1()
    }
}

struct ExampleView: View {
    @State private var counter = 0
    let scale: Double

    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .scaleEffect(scale)
    }
}

//struct Content2View: View {
////    @State private var scaleUp = false
////
////    var body: some View {
////        VStack {
//////            exampleView
////            ExampleView(scale: scaleUp ? 2 : 1)
////
////            Toggle("Scale Up", isOn: $scaleUp.animation())
////        }
////        .padding()
////    }
////
////    var exampleView: some View {
////        scaleUp ? ExampleView(scale: 2) : ExampleView(scale: 1)
////    }
//
//
//    @State private var isNewMessage = false
//
//    var body: some View {
//        VStack {
//            if isNewMessage {
//                Text("Message title here")
//                    .bold()
//            } else {
//                Text("Message title here")
//            }
//
//            Button("Toggle") {
//                withAnimation {
//                    isNewMessage.toggle()
//                }
//            }
//        }
//    }
//}

struct Content2View: View {
    //    @State private var items = Array(1...20)
    //
    //    var body: some View {
    //        VStack(spacing: 0) {
    //            List(items, id: \.self) {
    //                Text("Item \($0)")
    //            }
    //            .id(UUID())
    //            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    //
    //            Button("Shuffle") {
    ////                withAnimation(.easeInOut(duration: 1)) {
    //                    items.shuffle()
    ////                }
    //            }
    //            .buttonStyle(.borderedProminent)
    //            .padding(5)
    //        }
    //    }
    
//    let colors: [Color] = [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]
//    let symbols = ["run", "archery", "basketball", "bowling", "dance", "golf", "hiking", "jumprope", "rugby", "tennis", "volleyball", "yoga"]
//    @State private var id = UUID()
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Circle()
//                    .fill(colors.randomElement()!)
//                    .padding()
//
//                Image(systemName: "figure.\(symbols.randomElement()!)")
//                    .font(.system(size: 144))
//                    .foregroundColor(.white)
//            }
//            .transition(.slide)
//            .id(id)
//
//            Button("Change") {
//                withAnimation(.easeInOut(duration: 1)) {
//                    id = UUID()
//                }
//            }
//            .buttonStyle(.borderedProminent)
//            .padding(.bottom)
//        }
//    }
    
    var body: some View {
        Text("Hello")
            .background(Bool.random() ? Color.blue : nil)
            .onTapGesture {
                print(type(of: self.body))
            }
    }
}

struct Content2View_Previews: PreviewProvider {
    static var previews: some View {
        Content2View()
    }
}
