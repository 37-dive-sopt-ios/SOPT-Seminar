import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func loadImage(completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: "https://picsum.photos/200") else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil, let image = UIImage(data: data) else {
            completion(nil)
            return
        }
        completion(image) // 콜백은 백그라운드 스레드에서 호출될 수 있음
    }.resume()
}

loadImage { image in
    // ✅ UI 관련 작업은 반드시 메인 스레드에서
    DispatchQueue.main.async {
        if let image = image {
            let iv = UIImageView(image: image)
            iv.contentMode = .scaleAspectFit
            PlaygroundPage.current.setLiveView(iv)
            print("✅ 이미지 로드 + 표시 완료")
        } else {
            print("❌ 이미지 로드 실패")
        }
    }
}
