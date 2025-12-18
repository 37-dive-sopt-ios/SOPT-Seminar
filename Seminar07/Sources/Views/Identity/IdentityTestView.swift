//
//  IdentityTestView.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - CounterView

struct CounterView: View {

    // MARK: - Properties

    let title: String
    @State private var count = 0

    // MARK: - Body

    var body: some View {
        Button {
            count += 1
        } label: {
            VStack {
                Text(title)
                    .font(.headline)
                Text("카운트: \(count)")
                    .font(.title.bold())
                Text("(클릭해서 숫자를 올려보세요)")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
        .foregroundColor(.black)
    }
}

// MARK: - IdentityTestView

struct IdentityTestView: View {

    // MARK: - Properties

    @State private var changeColor: Bool = false

    // MARK: - Body

    var body: some View {
        VStack(spacing: 30) {
            switchButton

            Divider()

            ifElseExample

            ternaryExample
        }
        .padding()
    }

    // MARK: - View Components

    private var switchButton: some View {
        Button("배경색 바꾸기") {
            withAnimation {
                changeColor.toggle()
            }
        }
        .font(.title2)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }

    private var ifElseExample: some View {
        VStack {
            Text("A. If-Else 방식")
                .bold()
            Text("(Identity가 다름 -> State 초기화)")
                .font(.caption)
                .foregroundColor(.secondary)

            if changeColor {
                CounterView(title: "나는 빨강!")
                    .background(Color.red.opacity(0.3))
            } else {
                CounterView(title: "나는 초록!")
                    .background(Color.green.opacity(0.3))
            }
        }
        .padding()
        .border(.red, width: 2)
    }

    private var ternaryExample: some View {
        VStack {
            Text("B. 삼항연산자 방식")
                .bold()
            Text("(Identity가 같음 -> State 유지)")
                .font(.caption)
                .foregroundColor(.secondary)

            CounterView(title: "나는 변신쟁이!")
                .background(changeColor ? Color.red.opacity(0.3) : Color.green.opacity(0.3))
        }
        .padding()
        .border(.blue, width: 2)
    }
}

// MARK: - Preview

#Preview {
    IdentityTestView()
}
