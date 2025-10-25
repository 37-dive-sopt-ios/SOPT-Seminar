import Foundation

// MARK: - Model
/// MVC의 M (Model)
///
/// 📌 역할:
/// - 애플리케이션의 데이터를 표현
/// - 비즈니스 로직 처리 (유효성 검증, 데이터 변환 등)
/// - View와 Controller에 대해 전혀 알지 못함 (독립적)
///
/// 💡 이 모델은:
/// - 로그인 데이터를 저장하고
/// - 유효성 검증 로직을 제공합니다
public struct LoginModel {
    // MARK: - Properties
    var id: String = ""
    var password: String = ""

    // MARK: - Business Logic
    /// 입력값이 모두 비어있지 않은지 검증
    var isValid: Bool {
        return !id.isEmpty && !password.isEmpty
    }

    /// 비밀번호 최소 길이 검증
    var isPasswordValid: Bool {
        return password.count >= 6
    }

    /// 환영 메시지 생성 (비즈니스 로직)
    var welcomeMessage: String {
        return "\(id)님\n반가워요!"
    }
}
