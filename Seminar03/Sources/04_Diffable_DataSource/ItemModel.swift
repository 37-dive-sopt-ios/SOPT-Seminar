//
//  ItemModel.swift
//  Seminar03
//
//  Created by 이명진 on 10/28/25.
//

import UIKit

public struct ItemModel: Hashable {
    public let id: UUID
    public let title: String
    public let subtitle: String

    public init(id: UUID = UUID(), title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }

    public static var mockData: [ItemModel] = [
        ItemModel(title: "아이템 1", subtitle: "첫 번째 아이템"),
        ItemModel(title: "아이템 2", subtitle: "두 번째 아이템"),
        ItemModel(title: "아이템 3", subtitle: "세 번째 아이템"),
        ItemModel(title: "아이템 4", subtitle: "네 번째 아이템"),
        ItemModel(title: "아이템 5", subtitle: "다섯 번째 아이템")
    ]
}
