//
//  LoginView_SwiftUI.swift
//  Seminar05
//
//  Created by Claude on 11/15/25.
//

import SwiftUI

public struct LoginView_SwiftUI: View {
    
    // MARK: - Properties
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isNavigating: Bool = false
    
    // MARK: - Body
    public var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 116)

                titleView
                
                Spacer()
                    .frame(height: 72)
                
                idTextField
                
                passwordTextField
                
                Spacer()
                    .frame(height: 20)
                
                loginButton
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .navigationDestination(isPresented: $isNavigating) {
                WelcomeView_SwiftUI(username: username)
            }
        }
    }
    
    // MARK: - View Components
    private var titleView: some View {
        Text("동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요.")
            .font(.custom("Pretendard-Bold", size: 18))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
    }
    
    private var idTextField: some View {
        TextField("아이디를 입력해주세요", text: $username)
            .font(.custom("Pretendard-SemiBold", size: 14))
            .padding()
            .background(Color(red: 221/255, green: 222/255, blue: 227/255))
            .cornerRadius(8)
    }
    
    private var passwordTextField: some View {
        SecureField("비밀번호를 입력해주세요", text: $password)
            .font(.custom("Pretendard-SemiBold", size: 14))
            .padding()
            .background(Color(red: 221/255, green: 222/255, blue: 227/255))
            .cornerRadius(8)
    }
    
    private var loginButton: some View {
        Button(action: loginAction) {
            Text("로그인하기")
                .font(.custom("Pretendard-Bold", size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color(red: 255/255, green: 111/255, blue: 15/255))
                .cornerRadius(8)
        }
    }
    
    // MARK: - Actions
    private func loginAction() {
        isNavigating = true
    }
    
    // MARK: - Initialization
    public init() {}
}

// MARK: - Preview
#Preview {
    LoginView_SwiftUI()
}
