//
//  MVVMExampleView.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - MVVMExampleView

public struct MVVMExampleView: View {

    // MARK: - Properties

    @StateObject private var viewModel = CounterViewModel()

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 30) {
            titleSection
            countSection
            buttonSection
        }
        .padding()
    }

    // MARK: - View Components

    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("MVVM 카운터")
                .font(.largeTitle)
                .bold()

            Text(viewModel.message)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var countSection: some View {
        Text("\(viewModel.count)")
            .font(.system(size: 72, weight: .bold, design: .rounded))
            .foregroundColor(.blue)
    }

    private var buttonSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                Button {
                    viewModel.decrement()
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.red)
                }

                Button {
                    viewModel.increment()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.green)
                }
            }

            Button("초기화") {
                viewModel.reset()
            }
            .buttonStyle(.bordered)
        }
    }

    // MARK: - Initialization

    public init() {}
}

// MARK: - Preview

#Preview {
    MVVMExampleView()
}
