//
//  QiitaPost.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

struct QiitaPost: Decodable {
    
    let id: String
    let title: String
    let body: String
    let commentsCount: Int
    let likesCount: Int
    let reactionsCount: Int
    let user: QiitaUser
    let url: URL
    let createdAt: Date
    let updatedAt: Date
    
    // TODO: - CodingKeysを実装
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case commentsCount = "comments_count"
        case likesCount = "likes_count"
        case reactionsCount = "reactions_count"
        case user
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension QiitaPost {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        return formatter
    }()
    
    var createdAtString: String {
        // "YYYY/MM/dd"形式のStringに変換をして表示
        return QiitaPost.dateFormatter.string(from: createdAt)
    }
    
    var updatedAtString: String {
        // "YYYY/MM/dd"形式のStringに変換をして表示
        return QiitaPost.dateFormatter.string(from: updatedAt)
    }
}
