import UIKit
import SnapKit
import Core

// MARK: - View
/// MVC의 V (View)
/// - 사용자에게 보여지는 UI를 담당
/// - Model의 데이터를 화면에 표시
/// - 사용자의 입력을 받아 Controller에 전달
/// - 비즈니스 로직을 포함하지 않음
class UserView: UIView {

    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MVC 패턴 예제"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .darkGray
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .darkGray
        return label
    }()

    private let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .darkGray
        return label
    }()

    private let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()

    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("사용자 정보 변경", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setUI() {
        backgroundColor = .white
    }

    private func setHierarchy() {
        // Core 모듈의 addSubviews 활용
        addSubviews(
            titleLabel,
            nameLabel,
            ageLabel,
            hobbyLabel,
            introductionLabel,
            updateButton
        )
    }

    private func setLayout() {
        // SnapKit으로 깔끔한 레이아웃
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        ageLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        hobbyLabel.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        introductionLabel.snp.makeConstraints {
            $0.top.equalTo(hobbyLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        updateButton.snp.makeConstraints {
            $0.top.equalTo(introductionLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }

    // MARK: - Configuration
    /// View는 데이터를 어떻게 표시할지만 알면 됨
    func configure(with user: UserModel) {
        nameLabel.text = "이름: \(user.name)"
        ageLabel.text = "나이: \(user.age)세"
        hobbyLabel.text = "취미: \(user.hobby)"
        introductionLabel.text = user.introduction
    }
}
