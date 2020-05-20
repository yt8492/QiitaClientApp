//
//  AuthedUserRequest.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit

struct AuthedUserRequest: QiitaRequest {
    var token: String

    typealias Response = QiitaAuthedUser

    let path = "/authenticated_user"

    var method: HTTPMethod {
        return .get
    }

    init(loginToken: String) {
        self.token = loginToken
    }
}
