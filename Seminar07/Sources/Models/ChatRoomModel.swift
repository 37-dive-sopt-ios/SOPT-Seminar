//
//  ChatRoomModel.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - ChatRoomModel

public struct ChatRoomModel: Identifiable {
    public let id = UUID()
    public let profileImage: Image?
    public let name: String
    public let location: String
    public let lastMessage: String
    public let thumbnail: Image?
    
    public init(
        profileImage: Image?,
        name: String,
        location: String,
        lastMessage: String,
        thumbnail: Image?
    ) {
        self.profileImage = profileImage
        self.name = name
        self.location = location
        self.lastMessage = lastMessage
        self.thumbnail = thumbnail
    }
}

// MARK: - Mock Data

extension ChatRoomModel {
    public static let mockData: [ChatRoomModel] = [
        ChatRoomModel(
            profileImage: nil,
            name: "이명진",
            location: "문정동",
            lastMessage: "확인했습니다 감사합니다 :)",
            thumbnail: Image(systemName: "pencil.and.outline")
        ),
        ChatRoomModel(
            profileImage: Image(systemName: "person.crop.circle.fill"),
            name: "chan",
            location: "구의동",
            lastMessage: "넘 수고하세용",
            thumbnail: Image(systemName: "figure.run")
        ),
        ChatRoomModel(
            profileImage: Image(systemName: "person.crop.circle.fill"),
            name: "오지",
            location: "부문동2가",
            lastMessage: "안녕하세요 탈장이 너무 높았네여 ㅎ",
            thumbnail: Image(systemName: "headphones")
        ),
        ChatRoomModel(
            profileImage: nil,
            name: "누룽지",
            location: "면목동",
            lastMessage: "이랍다님이 이모티콘을 보냈어요.",
            thumbnail: Image(systemName: "paintbrush.pointed.fill")
        ),
        ChatRoomModel(
            profileImage: Image(systemName: "person.crop.circle.fill"),
            name: "kenny",
            location: "자양제4동",
            lastMessage: "네.",
            thumbnail: Image(systemName: "camera.fill")
        ),
        ChatRoomModel(
            profileImage: Image(systemName: "person.crop.circle.fill"),
            name: "자리보금",
            location: "옥수동",
            lastMessage: "자리보금님이 이모티콘을 보냈어요.",
            thumbnail: Image(systemName: "popcorn.fill")
        ),
        ChatRoomModel(
            profileImage: Image(systemName: "person.crop.circle.fill"),
            name: "리빙스텝",
            location: "면목동",
            lastMessage: "리빙스텝님이 이모티콘을 보냈어요.",
            thumbnail: Image(systemName: "shoeprints.fill")
        )
    ]
}
