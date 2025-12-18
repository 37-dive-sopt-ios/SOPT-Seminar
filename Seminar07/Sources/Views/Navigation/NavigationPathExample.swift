//
//  NavigationPathExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - NavigationPathExample

public struct NavigationPathExample: View {

    // MARK: - Properties

    @State private var path = NavigationPath()

    // MARK: - Body

    public var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 10) {
                Text("홈 화면")
                    .font(.largeTitle)

                Button("뷰 이동") {
                    path.append(1)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationDestination(for: Int.self) { step in
                StepView(step: step, path: $path)
            }
        }
    }

    // MARK: - Initialization

    public init() {}
}

// MARK: - StepView

struct StepView: View {

    // MARK: - Properties

    let step: Int
    @Binding var path: NavigationPath

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            Text("\(step)단계")
                .font(.largeTitle)

            Button("다음으로") {
                path.append(step + 1)
            }
            .buttonStyle(.borderedProminent)

            Button("처음으로") {
                path = NavigationPath()
            }
            .buttonStyle(.bordered)
            .foregroundColor(.red)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationPathExample()
}
