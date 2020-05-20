//
//  QiitaDataSource.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit
import Result

protocol QiitaPostRepositoryTypeDelegate: AnyObject {
    func qiitaPostDataSource(_ dataSource: QiitaPostRepositoryType, didFinishFetch posts: [QiitaPost])
    func qiitaPostDataSource(_ dataSource: QiitaPostRepositoryType, didReceive error: Error)
}

protocol QiitaPostRepositoryType {
    var delegate: QiitaPostRepositoryTypeDelegate? { get set }
    func fetchPosts(query: String?, page: Int)
}
