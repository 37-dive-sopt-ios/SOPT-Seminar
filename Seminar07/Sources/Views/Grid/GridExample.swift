//
//  GridExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - GridExample

struct GridExample: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: 30) {
            Text("기본 Grid")
                .font(.headline)

            basicGrid

            Divider()

            Text("색상 Grid")
                .font(.headline)

            colorGrid
        }
        .padding()
    }

    // MARK: - View Components

    private var basicGrid: some View {
        Grid {
            GridRow {
                Text("A")
                Text("B")
            }

            GridRow {
                Text("C")
                Text("D")
            }
        }
        .font(.title)
    }

    private var colorGrid: some View {
        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
            GridRow {
                Text("Row 1")
                    .frame(width: 60, alignment: .leading)
                ForEach(0..<2, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                }
            }

            GridRow {
                Text("Row 2")
                    .frame(width: 60, alignment: .leading)
                ForEach(0..<5, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.green)
                        .frame(width: 50, height: 50)
                }
            }

            GridRow {
                Text("Row 3")
                    .frame(width: 60, alignment: .leading)
                ForEach(0..<4, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    GridExample()
}
