//
//  QiitaPostRepository.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit
import Result

class QiitaPostRepository : QiitaPostRepositoryType {
    
    static let shared = QiitaPostRepository()
    weak var delegate: QiitaPostRepositoryTypeDelegate?
    private let session = Session.shared
    
    private init() {}

    func fetchPosts(query: String? = nil, page: Int = 1) {
        let request = SearchPostRequest(query: query, page: page)
        session.send(request) { [weak self] result in
            guard let me = self else {
                return
            }
            switch result {
            case .success(let value):
                me.delegate?.qiitaPostDataSource(me, didFinishFetch: value)
            case .failure(let error):
                me.delegate?.qiitaPostDataSource(me, didReceive: error)
            }
        }
    }

}
