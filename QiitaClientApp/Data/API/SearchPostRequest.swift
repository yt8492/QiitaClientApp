//
//  SearchPostRequest.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit

struct SearchPostRequest: QiitaRequest {
    typealias Response = [QiitaPost]

    let path = "/items"

    var token: String {
        guard let token = ProcessInfo.processInfo.environment["QIITA_TOKEN"] else {
            fatalError("Acces Token is must to be configured")
        }
        return token
    }

    var method: HTTPMethod {
        return .get
    }

    var queryParameters: [String : Any]? {
        var param: [String : Any] = [:]
        if let query = query {
            param.updateValue(query, forKey: "query")
        }
        param.updateValue(page, forKey: "page")
        return param
    }

    let query: String?
    let page: Int

    init(query: String?, page: Int) {
        self.query = query
        self.page = page
    }
}
