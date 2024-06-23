//
//  MainView.swift
//  DrawingApp
//
//  Created by Анастасия Прохорова on 24.06.24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("1")
                    .foregroundStyle(.primary)
                Text("2")
                    .foregroundStyle(.primary)
                Text("3")
                    .foregroundStyle(.primary)
            }
            .navigationTitle("Drawing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewCanvasView()
                    } label: {
                        Text("New canvas")
                            .font(.body)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
