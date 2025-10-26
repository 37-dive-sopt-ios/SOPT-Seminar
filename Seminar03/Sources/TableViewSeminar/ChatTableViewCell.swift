//
//  ChatTableViewCell.swift
//  Seminar03
//
//  Created by 이명진 on 10/26/25.
//

import UIKit
import SnapKit
import Core

final class ChatTableViewCell: UITableViewCell {
    
    static let identifier: String = "ChatTableViewCell"

    // MARK: - UI Components

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray5
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setUI() {
        selectionStyle = .none
        backgroundColor = .white
    }

    private func setHierarchy() {
        contentView.addSubviews(
            profileImageView,
            nameLabel,
            statusLabel,
            messageLabel,
            thumbnailImageView
        )
    }

    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(0.5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }

        statusLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(nameLabel)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }

    // MARK: - Configuration

    func configure(with chatRoom: ChatRoom) {
        profileImageView.image = chatRoom.profileImage
        nameLabel.text = chatRoom.name
        statusLabel.text = chatRoom.statusMessage
        messageLabel.text = chatRoom.lastMessage
        thumbnailImageView.image = chatRoom.thumbnail
    }
}


#Preview {
    ChatViewController()
}
