//
//  CharViewController.swift
//  Seminar03
//
//  Created by 이명진 on 10/26/25.
//

import UIKit
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
        setTableView()
        setLayout()
        loadMockData()
    }
    
    // MARK: - UI Setup
    
    private func setUI() {
        view.backgroundColor = .white
        title = "채팅"
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 80
    }
    
    private func setLayout() { // -- 3번
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Data
    
    private func loadMockData() {
        chatRooms = [
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "이명진",
                statusMessage: "분정동",
                lastMessage: "확인했습니다 감사합니다 :)",
                thumbnail: UIImage(systemName: "photo")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "chan",
                statusMessage: "구의동",
                lastMessage: "넵 수고하세용",
                thumbnail: UIImage(systemName: "photo")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "오지",
                statusMessage: "보문동2가",
                lastMessage: "안녕하세요 답장이 너무 늦었네여 죄송...",
                thumbnail: UIImage(systemName: "headphones")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "누룽지",
                statusMessage: "연목동",
                lastMessage: "이알다님이 이모티콘을 보냈어요.",
                thumbnail: UIImage(systemName: "photo")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "kenny",
                statusMessage: "자양제4동",
                lastMessage: "네.",
                thumbnail: UIImage(systemName: "photo")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "자리보금",
                statusMessage: "옥수동",
                lastMessage: "자리보금님이 이모티콘을 보냈어요.",
                thumbnail: UIImage(systemName: "photo")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "리빙스턴",
                statusMessage: "연목동",
                lastMessage: "리빙스턴님이 이모티콘을 보냈어요.",
                thumbnail: UIImage(systemName: "sportscourt")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "까롱이",
                statusMessage: "중곡동",
                lastMessage: "옷 예뻐네요!",
                thumbnail: UIImage(systemName: "leaf")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "깨롱이",
                statusMessage: "중곡동",
                lastMessage: "네.",
                thumbnail: UIImage(systemName: "photo")
            ),
            ChatRoom(
                profileImage: UIImage(systemName: "person.circle.fill"),
                name: "요우",
                statusMessage: "근자동",
                lastMessage: "감사합니다! 조심하거세요!",
                thumbnail: UIImage(systemName: "photo")
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
