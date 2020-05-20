//
//  ArticleListView.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

protocol QiitaPostListView: AnyObject {
    var query: String? { get }
    var fetching: Bool { get set }
    func showPosts(_ posts: [QiitaPost])
    func showSearchResult(query: String)
    func showError(_ error: Error)
    func openArticle(_ post: QiitaPost)
}
