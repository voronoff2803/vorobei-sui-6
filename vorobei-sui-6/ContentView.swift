//
//  ContentView.swift
//  vorobei-sui-6
//
//  Created by Alexey Voronov on 15.10.2023.
//


import SwiftUI

enum SquareOrder {
    case horizontal, diagonal
}

struct ContentView: View {
    @State private var order: SquareOrder = .horizontal
    
    let count = 7
    let spacing: CGFloat = 8.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<count, id: \.self) { index in
                    let frame = frame(for: index, in: geometry.size)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.accentColor)
                        .frame(width: frame.x, height: frame.y)
                        .position(position(for: index, in: geometry.size))
                        .onTapGesture {
                            withAnimation {
                                toggleOrder()
                            }
                        }
                }
            }
        }
    }
    
    private func toggleOrder() {
        order = (order == .horizontal) ? .diagonal : .horizontal
    }
    
    private func position(for index: Int, in size: CGSize) -> CGPoint {
        switch order {
        case .horizontal:
            let squareWidth = (size.width - CGFloat(count - 1) * spacing) / CGFloat(count)
            let x = (CGFloat(index) * (squareWidth + spacing)) + squareWidth/2
            let y = size.height / 2
            return CGPoint(x: x, y: y)
            
        case .diagonal:
            let frame = size.height / CGFloat(count)
            let x = CGFloat(index) * ((size.width - frame) / CGFloat(count - 1)) + frame / 2.0
            let y = (CGFloat(count - index - 1) + 0.5) * size.height / CGFloat(count)
            return CGPoint(x: x, y: y)
        }
    }
    
    private func frame(for index: Int, in size: CGSize) -> CGPoint {
        switch order {
        case .horizontal:
            let x = (size.width - CGFloat(count - 1) * spacing) / CGFloat(count)
            return CGPoint(x: x, y: x)
            
        case .diagonal:
            let x = size.height / CGFloat(count)
            let y = x
            return CGPoint(x: x, y: y)
        }
    }
}

#Preview {
    ContentView()
}
