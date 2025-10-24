import Foundation

// MARK: - Model
/// MVC의 M (Model)
/// - 데이터와 비즈니스 로직을 담당
/// - View나 Controller에 대해 알 필요가 없음
/// - 데이터의 상태를 관리하고, 데이터 변경 로직을 포함
struct UserModel {
    let name: String
    let age: Int
    let hobby: String

    // 비즈니스 로직 예시
    var introduction: String {
        return "\(name)님은 \(age)살이고, \(hobby)을/를 좋아합니다."
    }

    var isAdult: Bool {
        return age >= 20
    }
}
