import ProjectDescription

// MARK: - Seminar Configuration

/// 세미나별 Configuration을 관리하는 열거형
public enum SeminarConfig: String, CaseIterable {
    case seminar01 = "Seminar01"
    case seminar02 = "Seminar02"
    case seminar02Closure = "Seminar02Closure"
    case seminar03 = "Seminar03"
    case seminar03MVC = "Seminar03MVC"

    /// Configuration 이름
    var configurationName: ConfigurationName {
        .configuration(rawValue)
    }

    /// 컴파일 플래그 (Swift Active Compilation Conditions)
    var compilationFlag: String {
        switch self {
        case .seminar01:
            return "SEMINAR01"
        case .seminar02:
            return "SEMINAR02"
        case .seminar02Closure:
            return "SEMINAR02_CLOSURE"
        case .seminar03:
            return "SEMINAR03"
        case .seminar03MVC:
            return "SEMINAR03_MVC"
        }
    }

    /// Tuist Configuration 객체 생성
    var configuration: Configuration {
        .debug(
            name: configurationName,
            settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": .string(compilationFlag)]
        )
    }
}

// MARK: - Public Configurations

/// 모든 세미나 Configuration 목록 (공통 Debug/Release 포함)
public let allConfigurations: [Configuration] = {
    var configs = SeminarConfig.allCases.map { $0.configuration }
    configs.append(contentsOf: [
        .debug(name: .configuration("Debug")),
        .release(name: .configuration("Release"))
    ])
    return configs
}()

/// 세미나 Configuration만 포함 (Debug/Release 제외)
public let seminarConfigurations: [Configuration] = SeminarConfig.allCases.map { $0.configuration }
