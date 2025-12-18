//
//  CounterViewModel.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI
import Combine

// MARK: - CounterViewModel

final class CounterViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var count: Int = 0
    @Published var message: String = "버튼을 눌러보세요!"

    // MARK: - Actions

    func increment() {
        count += 1
        updateMessage()
    }

    func decrement() {
        count -= 1
        updateMessage()
    }

    func reset() {
        count = 0
        message = "초기화되었습니다!"
    }

    // MARK: - Private Methods

    private func updateMessage() {
        if count > 10 {
            message = "와! 10을 넘었어요!"
        } else if count < 0 {
            message = "마이너스네요..."
        } else {
            message = "현재 카운트: \(count)"
        }
    }
}
