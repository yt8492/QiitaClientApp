//
//  QiitaRequest.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit

protocol QiitaRequest: Request where Response: Decodable {
    var token: String { get }
}

extension QiitaRequest {
    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }
    
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    var headerFields: [String : String] {
        return ["Authorization" : "Bearer \(token)"]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        
        // Qiita APIで返ってくる日付は、ISO8601
        decoder.dateDecodingStrategy = .iso8601
        
        // DecodableDataParserでDataを返しているので、force castしても問題ない
        return try decoder.decode(Response.self, from: object as! Data)
    }
}

/// Decodable向けのDataParser
struct DecodableDataParser: DataParser {
    let contentType: String? = "application/json"
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
