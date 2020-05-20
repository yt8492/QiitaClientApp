//
//  QiitaUser.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

struct QiitaUser: Decodable {
    
    let id: String
    let profileImageURL: URL?
    
    // TODO: - CodingKeysを実装
    enum CodingKeys: String, CodingKey {
        case id
        case profileImageURL = "profile_image_url"
    }
}
