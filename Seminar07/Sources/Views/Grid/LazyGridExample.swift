//
//  LazyGridExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - LazyVGridExample

struct LazyVGridExample: View {

    // MARK: - Properties

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Body

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0x1f600...0x1f679, id: \.self) { value in
                    VStack {
                        Text(String(format: "%x", value))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(emoji(value))
                            .font(.largeTitle)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }

    // MARK: - Helper Methods

    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}

// MARK: - LazyHGridExample

struct LazyHGridExample: View {

    // MARK: - Properties

    let rows = [
        GridItem(.fixed(30), spacing: 1),
        GridItem(.fixed(60), spacing: 10),
        GridItem(.fixed(90), spacing: 20),
        GridItem(.fixed(10), spacing: 50)
    ]

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 5) {
                ForEach(0...300, id: \.self) { _ in
                    Color.red.frame(width: 30)
                    Color.green.frame(width: 30)
                    Color.blue.frame(width: 30)
                    Color.yellow.frame(width: 30)
                }
            }
        }
    }
}

// MARK: - GridItemExample

struct GridItemExample: View {

    // MARK: - Properties

    let adaptiveColumns = [
        GridItem(.adaptive(minimum: 80))
    ]

    let flexibleColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Adaptive Grid")
                    .font(.headline)

                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(0..<20, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            .frame(height: 60)
                            .overlay(
                                Text("\(index)")
                                    .foregroundColor(.white)
                            )
                    }
                }

                Divider()

                Text("Flexible Grid (3 columns)")
                    .font(.headline)

                LazyVGrid(columns: flexibleColumns, spacing: 10) {
                    ForEach(0..<15, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green)
                            .frame(height: 60)
                            .overlay(
                                Text("\(index)")
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview("LazyVGrid") {
    LazyVGridExample()
}

#Preview("LazyHGrid") {
    LazyHGridExample()
}

#Preview("GridItem") {
    GridItemExample()
}
