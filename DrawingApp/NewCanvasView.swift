//
//  Untitled.swift
//  DrawingApp
//
//  Created by Анастасия Прохорова on 23.06.24.
//

import SwiftUI
import PencilKit

struct NewCanvasView: View {
    
    @State private var canvas = PKCanvasView()
    @State private var drawingPolicy: PKCanvasViewDrawingPolicy = .anyInput
    
    var body: some View {
        NavigationStack {
            DrawingCanvasView(canvas: $canvas, drawingPolicy: $drawingPolicy)
                .navigationTitle("New canvas")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if !UIPencilInteraction.prefersPencilOnlyDrawing {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                if drawingPolicy == .anyInput {
                                    drawingPolicy = .pencilOnly
                                } else if drawingPolicy == .pencilOnly {
                                    drawingPolicy = .anyInput
                                }
                            } label: {
                                HStack(spacing: 8) {
                                    Image(systemName: drawingPolicy == .pencilOnly ? "pencil.tip" : "pencil")
                                        .foregroundStyle(.primary)
                                        .font(.title2)
                                    Text(drawingPolicy == .pencilOnly ? "Only Pencil" : "All")
                                        .foregroundStyle(.primary)
                                        .font(.body)
                                }
                            }
                        }
                    }
                }
        }
        .padding(0)
    }
}

#Preview {
    NewCanvasView()
}

struct DrawingCanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var drawingPolicy: PKCanvasViewDrawingPolicy
    
    var ink: PKInkingTool {
        PKInkingTool(.pencil, color: .black, width: 10)
    }
    
    let picker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        if UIPencilInteraction.prefersPencilOnlyDrawing {
            canvas.drawingPolicy = .pencilOnly
        } else {
            canvas.drawingPolicy = drawingPolicy
        }
        canvas.tool = ink
        canvas.isScrollEnabled = true
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        picker.addObserver(uiView)
        picker.setVisible(true, forFirstResponder: uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
        if UIPencilInteraction.prefersPencilOnlyDrawing {
            canvas.drawingPolicy = .pencilOnly
        } else {
            canvas.drawingPolicy = drawingPolicy
        }
    }
}
