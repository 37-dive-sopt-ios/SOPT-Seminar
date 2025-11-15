//
//  WelcomeView_SwiftUI.swift
//  Seminar05
//
//  Created by Claude on 11/15/25.
//

import SwiftUI

public struct WelcomeView_SwiftUI: View {

    // MARK: - Properties
    let username: String
    @Environment(\.dismiss) private var dismiss

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 87)

            logoImageView

            Spacer()
                .frame(height: 58)

            welcomeLabel

            Spacer()
                .frame(height: 71)

            goHomeButton

            Spacer()
                .frame(height: 14)

            backToLoginButton

            Spacer()
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - View Components
    private var logoImageView: some View {
        Image("logo2")
            .resizable()
            .frame(width: 150, height: 150)
    }

    private var welcomeLabel: some View {
        Text("\(username)님\n반가워요!")
            .font(.custom("Pretendard-ExtraBold", size: 25))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .lineSpacing(4)
    }

    private var goHomeButton: some View {
        Button(action: goHomeAction) {
            Text("메인으로")
                .font(.custom("Pretendard-Bold", size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(Color(red: 255/255, green: 111/255, blue: 15/255))
                .cornerRadius(8)
        }
    }

    private var backToLoginButton: some View {
        Button(action: backToLoginAction) {
            Text("다시 로그인")
                .font(.custom("Pretendard-Bold", size: 18))
                .foregroundColor(Color(red: 172/255, green: 176/255, blue: 185/255))
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(Color(red: 221/255, green: 222/255, blue: 227/255))
                .cornerRadius(8)
        }
    }

    // MARK: - Actions
    private func goHomeAction() {
        // 메인으로 가는 로직 (현재는 비어있음)
    }

    private func backToLoginAction() {
        // NavigationStack에서는 dismiss를 통해 이전 화면으로 돌아감
        dismiss()
    }

    // MARK: - Initialization
    public init(username: String) {
        self.username = username
    }
}

// MARK: - Preview
#Preview {
    WelcomeView_SwiftUI(username: "테스트")
}
