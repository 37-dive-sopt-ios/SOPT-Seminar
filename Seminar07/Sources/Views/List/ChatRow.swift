//
//  ChatRow.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - ChatRow

struct ChatRow: View {

    // MARK: - Properties

    let chatRoom: ChatRoomModel

    // MARK: - Body

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            profileImageView
            textContentView
            Spacer()
            thumbnailView
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }

    // MARK: - View Components

    private var profileImageView: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 50, height: 50)

            if let profileImage = chatRoom.profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
        }
    }

    private var textContentView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Text(chatRoom.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)

                Text(chatRoom.location)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Text(chatRoom.lastMessage)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private var thumbnailView: some View {
        if let thumbnail = chatRoom.thumbnail {
            thumbnail
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

// MARK: - Preview

#Preview {
    ChatRow(chatRoom: ChatRoomModel.mockData[0])
}
