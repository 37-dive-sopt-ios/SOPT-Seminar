//
//  protocol.swift
//  Seminar02
//
//  Created by 이명진 on 10/17/25.
//

import UIKit

// MARK: - 실제 사용 예시: TextField Delegate 패턴

protocol TextFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(_ textField: CustomTextField)
    func textFieldDidEndEditing(_ textField: CustomTextField)
    func textFieldDidChangeText(_ textField: CustomTextField, text: String)
}

class CustomTextField {
    weak var delegate: TextFieldDelegate?
    var text: String = "" {
        didSet {
            delegate?.textFieldDidChangeText(self, text: text)
        }
    }

    func beginEditing() {
        print("텍스트 필드 편집 시작")
        delegate?.textFieldDidBeginEditing(self)
    }

    func endEditing() {
        print("텍스트 필드 편집 종료")
        delegate?.textFieldDidEndEditing(self)
    }
}

class LoginViewController: TextFieldDelegate {
    let emailTextField = CustomTextField()
    let passwordTextField = CustomTextField()

    init() {
        // 💡 이렇게 .delegate = self 로 채택합니다!
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    // MARK: - TextFieldDelegate 구현
    func textFieldDidBeginEditing(_ textField: CustomTextField) {
        if textField === emailTextField {
            print("✅ 이메일 입력 시작!")
        } else if textField === passwordTextField {
            print("✅ 비밀번호 입력 시작!")
        }
    }

    func textFieldDidEndEditing(_ textField: CustomTextField) {
        if textField === emailTextField {
            print("✅ 이메일 입력 완료: \(textField.text)")
        } else if textField === passwordTextField {
            print("✅ 비밀번호 입력 완료: \(textField.text)")
        }
    }

    func textFieldDidChangeText(_ textField: CustomTextField, text: String) {
        if textField === emailTextField {
            print("📝 이메일 변경: \(text)")
        } else if textField === passwordTextField {
            print("📝 비밀번호 변경: \(text)")
        }
    }
}

// MARK: - 세미나 예시

/*
 델리게이트 패턴 5단계 설명:

 1️⃣ Protocol 정의: 깃허브미미나 - 해야 할 일들을 정의
 2️⃣ 이명진 클래스: weak var 파트원: 깃허브미미나? - delegate를 가지고 있음
 3️⃣ 선영주 클래스가 Protocol 채택: class 선영주: 깃허브미미나 - 실제 일을 처리
 4️⃣ init에서 이명진.파트원 = self: 이명진이 메소드 호출하면 → 선영주가 실제로 실행
 5️⃣ 이명진의 깃허브미미나() 호출: 파트원?.깃허브미미나실제로진행하기() → 선영주의 메소드가 실행됨
 */

// 1️⃣ Protocol 정의 - 해야 할 일 정의
protocol 깃허브미미나: AnyObject {
    func 깃허브미미나실제로진행하기()
}

protocol iOS파트장세미나내용2주차 {
    func 데이터전달()
    func 프로토콜()
    func 델리게이트패턴()
    func 익스텐션()
    func 오토레이아웃()
}

// 2️⃣ 이명진 클래스 - delegate를 가지고 있음
class iOS파트장: iOS파트장세미나내용2주차 {

    weak var 파트원: 깃허브미미나?
    // 깃허브 미미나를 할 수 있는 파트원을 가지고 있습니다. (옵셔널 이기 때문에 의존을 하진 않습니다.)

    func 데이터전달() {
        print("데이터 전달은 크게 2가지로 나눠집니다 ... 블라블라")
    }

    func 프로토콜() {
        print("추상화 .. 프로토콜 확장 너무 중요해요")
    }

    func 델리게이트패턴() {
        print("짬 때리기 라는겁니다")
    }

    func 익스텐션() {
        print("익스텐션이 그냥 코드 추가하는 것만 알면 안됩니다.")
    }

    func 오토레이아웃() {
        print("SnapKit 할까? ㅋㅋ")
    }

    // 5️⃣ delegate 메소드 호출 - 실제로는 선영주가 실행
    func 깃허브미미나() {
        print("이명진: 깃허브 미미나는... 음... 영주야! 부탁해!")
        파트원?.깃허브미미나실제로진행하기()
    }

    func 세미나() {
        print("=== 이명진 파트장의 세미나 시작! ===\n")

        print("1. 데이터 전달")
        데이터전달()

        print("\n2. 프로토콜")
        프로토콜()

        print("\n3. 델리게이트 패턴")
        델리게이트패턴()

        print("\n4. 익스텐션")
        익스텐션()

        print("\n5. 오토레이아웃")
        오토레이아웃()

        print("\n6. 깃허브 미미나 (파트원에게 위임)")
        깃허브미미나()
    }
}

// 3️⃣ 선영주 클래스 - Protocol 채택, 실제 일을 처리
class 선영주: 깃허브미미나 {

    var 이명진: iOS파트장

    // 4️⃣ init에서 이명진.파트원 = self 설정
    init(이명진: iOS파트장) {
        self.이명진 = 이명진
        // 💡 box.delegate = self 패턴!
        이명진.파트원 = self
    }

    // MARK: - 깃허브미미나Delegate 구현 (실제 일 처리)
    func 깃허브미미나실제로진행하기() {
        print("선영주: 네! 제가 깃허브 미미나 진행하겠습니다!")
        print("선영주: YB들~ git add, git commit, git push 순서대로 하면 돼요! ㅎㅎ")
        print("선영주: 궁금한 거 있으면 언제든 물어보세요~")
    }
}
