//
//  CharViewController.swift
//  Seminar03
//
//  Created by 이명진 on 10/26/25.
//

import UIKit
import Core
import SnapKit

public final class ChatViewController: UIViewController { // -- 1번
    
    // MARK: - UI Components
    
    private let tableView = UITableView(frame: .zero, style: .plain) // -- 2번
    
    // MARK: - Properties
    
    private var chatRooms: [ChatRoomModel] = []
    
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
        chatRooms = ChatRoomModel.mockData
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
