//
//  QiitaAuthedUser.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

struct QiitaAuthedUser: Decodable {
    let id: String
    let name: String?
    let organization: String?
    let description: String?
    let profileImageUrl: URL?
    let websiteUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case organization
        case description
        case profileImageUrl = "profile_image_url"
        case websiteUrl = "website_url"
    }
}
