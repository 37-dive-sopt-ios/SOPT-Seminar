import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func fetchImageData() async throws -> Data {
    let url = URL(string: "https://picsum.photos/200")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

Task {
    do {
        let data = try await fetchImageData()
        guard let image = UIImage(data: data) else {
            print("❌ 이미지 변환 실패")
            return
        }

        // ✅ 메인 액터에서 UI 업데이트
        await MainActor.run {
            let iv = UIImageView(image: image)
            iv.contentMode = .scaleAspectFit
            print("✅ 이미지 로드 + 표시 완료 (async)")
        }
    } catch {
        print("❌ 네트워크 에러:", error.localizedDescription)
    }
}
