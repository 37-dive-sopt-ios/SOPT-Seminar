//
//  SheetExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - SheetExample

public struct SheetExample: View {

    // MARK: - Properties

    @State private var showSheet = false

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 20) {
            Text("메인 화면")
                .font(.largeTitle)

            Button("시트 열기") {
                showSheet = true
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showSheet) {
            SheetContentView()
        }
    }

    // MARK: - Initialization

    public init() {}
}

// MARK: - SheetContentView

struct SheetContentView: View {

    // MARK: - Properties

    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            Text("시트 화면")
                .font(.largeTitle)

            Text("dismiss()를 호출하여 시트를 닫을 수 있습니다")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("닫기") {
                dismiss()
            }
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - Preview

#Preview {
    SheetExample()
}
