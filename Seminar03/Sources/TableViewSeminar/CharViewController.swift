//
//  CharViewController.swift
//  Seminar03
//
//  Created by 이명진 on 10/26/25.
//

import UIKit
import Core
import SnapKit

public struct ChatRoom {
    let profileImage: UIImage?
    let name: String
    let statusMessage: String
    let lastMessage: String
    let thumbnail: UIImage?
}

public final class ChatViewController: UIViewController { // -- 1번
    
    // MARK: - Model
    
    
    // MARK: - UI Components
    
    private let tableView = UITableView(frame: .zero, style: .plain) // -- 2번
    
    // MARK: - Properties
    
    private var chatRooms: [ChatRoom] = []
    
    // MARK: - Initialization
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        register()
        setDelegate()
        setLayout()
        loadMockData()
    }
    
    // MARK: - UI Setup
    
    private func setUI() {
        view.backgroundColor = .white
        title = "채팅"
        tableView.separatorStyle = .singleLine
    }
    
    private func setLayout() { // -- 3번
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func register() {
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Data
    
    private func loadMockData() {
        chatRooms = [
            ChatRoom(
                profileImage: UIImage(named: "profile1"),
                name: "이명진",
                statusMessage: "분정동",
                lastMessage: "확인했습니다 감사합니다 :)",
                thumbnail: UIImage(named: "item1")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile2"),
                name: "안치욱",
                statusMessage: "구의동",
                lastMessage: "넵 수고하세용",
                thumbnail: UIImage(named: "item2")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile3"),
                name: "오지",
                statusMessage: "보문동2가",
                lastMessage: "안녕하세요 답장이 너무 늦었네여 죄송...",
                thumbnail: UIImage(named: "item3")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile4"),
                name: "누룽지",
                statusMessage: "연목동",
                lastMessage: "이알다님이 이모티콘을 보냈어요.",
                thumbnail: UIImage(named: "item4")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile5"),
                name: "kenny",
                statusMessage: "자양제4동",
                lastMessage: "네.",
                thumbnail: UIImage(named: "item5")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile6"),
                name: "자리보금",
                statusMessage: "옥수동",
                lastMessage: "자리보금님이 이모티콘을 보냈어요.",
                thumbnail: UIImage(named: "item6")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile1"),
                name: "리빙스턴",
                statusMessage: "연목동",
                lastMessage: "리빙스턴님이 이모티콘을 보냈어요.",
                thumbnail: UIImage(named: "item7")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile2"),
                name: "까롱이",
                statusMessage: "중곡동",
                lastMessage: "옷 예뻐네요!",
                thumbnail: UIImage(named: "item8")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile3"),
                name: "깨롱이",
                statusMessage: "중곡동",
                lastMessage: "네.",
                thumbnail: UIImage(named: "item9")
            ),
            ChatRoom(
                profileImage: UIImage(named: "profile4"),
                name: "요우",
                statusMessage: "근자동",
                lastMessage: "감사합니다! 조심하거세요!",
                thumbnail: UIImage(named: "item10")
            )
        ]
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(chatRooms[indexPath.row].name) 채팅방 선택됨")
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: chatRooms[indexPath.row])
        return cell
    }
}
