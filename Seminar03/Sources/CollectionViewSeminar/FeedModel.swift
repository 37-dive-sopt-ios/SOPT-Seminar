//
//  FeedModel.swift
//  Seminar03
//
//  Created by 이명진 on 10/27/25.
//

import UIKit

public struct FeedModel {
    let itemImg: UIImage
    let name: String
    let price: String
    var isScrap: Bool

    static let mockData: [FeedModel] = [
        FeedModel(itemImg: UIImage(named: "feed1") ?? UIImage(), name: "아이폰 13프로맥스", price: "1,000,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed2") ?? UIImage(), name: "에어팟 프로", price: "300,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed3") ?? UIImage(), name: "커피머신", price: "100,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed4") ?? UIImage(), name: "샌드위치", price: "8,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed5") ?? UIImage(), name: "명품 핸수", price: "250,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed1") ?? UIImage(), name: "아이폰 13프로맥스", price: "1,000,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed2") ?? UIImage(), name: "에어팟 프로", price: "300,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed3") ?? UIImage(), name: "커피머신", price: "100,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed4") ?? UIImage(), name: "샌드위치", price: "8,000원", isScrap: false),
        FeedModel(itemImg: UIImage(named: "feed5") ?? UIImage(), name: "명품 핸수", price: "250,000원", isScrap: false)
    ]
}
