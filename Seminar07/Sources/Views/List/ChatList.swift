//
//  ChatList.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - ChatList

public struct ChatList: View {

    // MARK: - Properties

    let chatRooms: [ChatRoomModel]

    // MARK: - Body

    public var body: some View {
        List(chatRooms) { chatRoom in
            ChatRow(chatRoom: chatRoom)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.visible)
        }
        .listStyle(.plain)
    }

    // MARK: - Initialization

    public init(chatRooms: [ChatRoomModel] = ChatRoomModel.mockData) {
        self.chatRooms = chatRooms
    }
}

// MARK: - Preview

#Preview {
    ChatList(chatRooms: ChatRoomModel.mockData)
}
