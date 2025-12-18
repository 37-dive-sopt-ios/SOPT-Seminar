//
//  DestinationView.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - DestinationView

public struct DestinationView: View {

    // MARK: - Properties

    @State private var path = NavigationPath()

    // MARK: - Body

    public var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Button("첫번째 버튼") {
                    path.append("이거 넘겨줄게")
                }
                .buttonStyle(.borderedProminent)

                Button("두번째 버튼") {
                    path.append("요거 넘겨줄게")
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationDestination(for: String.self) { str in
                DestinationDetailView(text: str, path: $path)
            }
        }
    }

    // MARK: - Initialization

    public init() {}
}

// MARK: - DestinationDetailView

struct DestinationDetailView: View {

    // MARK: - Properties

    var text: String
    @Binding var path: NavigationPath

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.largeTitle)

            Text("현재 깊이: \(path.count)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button("다음 화면으로") {
                path.append("DetailView에서 넘어간 화면")
            }
            .buttonStyle(.borderedProminent)

            Button("루트뷰로 이동") {
                path = NavigationPath()
            }
            .buttonStyle(.bordered)
            .foregroundColor(.red)
        }
    }
}

// MARK: - Preview

#Preview {
    DestinationView()
}
