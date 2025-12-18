//
//  StateBindingExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - PlayButton

struct PlayButton: View {

    // MARK: - Properties

    @Binding var isPlaying: Bool

    // MARK: - Body

    var body: some View {
        Button(isPlaying ? "일시정지" : "재생") {
            isPlaying.toggle()
        }
        .font(.title2)
        .padding()
        .background(isPlaying ? Color.red : Color.green)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

// MARK: - PlayerView

struct PlayerView: View {

    // MARK: - Properties

    @State private var isPlaying: Bool = false

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            Text("Player View")
                .font(.largeTitle)
                .bold()

            Text("현재 상태: \(isPlaying ? "재생 중" : "정지")")
                .foregroundStyle(isPlaying ? .primary : .secondary)

            PlayButton(isPlaying: $isPlaying)

            Divider()

            Text("@State는 PlayerView가 소유하고,\nPlayButton은 $를 통해 Binding을 전달받습니다.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

// MARK: - StateExample

struct StateExample: View {

    // MARK: - Properties

    @State private var tapCount = 0
    @State private var name = ""

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            Text("State Example")
                .font(.largeTitle)
                .bold()

            Text("탭 횟수: \(tapCount)")
                .font(.title)

            Button("탭하세요!") {
                tapCount += 1
            }
            .buttonStyle(.borderedProminent)

            Divider()

            TextField("이름을 입력하세요", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Text("안녕하세요, \(name.isEmpty ? "Guest" : name)님!")
                .font(.headline)
        }
        .padding()
    }
}

// MARK: - Preview

#Preview("PlayerView") {
    PlayerView()
}

#Preview("StateExample") {
    StateExample()
}
