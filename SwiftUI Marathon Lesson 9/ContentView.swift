//
//  ContentView.swift
//  SwiftUI Marathon Lesson 9
//
//  Created by Magomet Bekov on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var offSet: CGSize = .zero
    
    private var point: CGPoint {
        CGPoint(x: UIScreen.main.bounds.width / 2.0,y: UIScreen.main.bounds.height / 2.0)
    }
    
    var body: some View {
        Canvas { context, size in
            let shapeOne = context.resolveSymbol(id: 1)!
            let shapeTwo = context.resolveSymbol(id: 2)!
            
            context.addFilter(.alphaThreshold(min: 0.5, color: .blue))
            
            context.addFilter(.blur(radius: 25))
            
            context.drawLayer { context in
                context.draw(shapeOne, at: point)
                context.draw(shapeTwo, at: point)
            }
        } symbols: {
            Capsule()
                .frame(width: 200, height: 50)
                .tag(1)
            Ellipse()
                .frame(width: 100, height: 150)
                .offset(x: offSet.width, y: offSet.height)
                .tag(2)
        }
        .gesture(DragGesture()
            .onChanged { value in
                offSet = value.translation
            }.onEnded { value in
                withAnimation(.spring(bounce: 0.3)) {
                    offSet = .zero
                }
            })
    }
}

#Preview {
    ContentView()
}
