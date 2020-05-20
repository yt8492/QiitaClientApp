//
//  ArticleListPresenter.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

protocol QiitaPostListPresenterType: AnyObject {
    var qiitaPostRepository: QiitaPostRepositoryType { get }
    var qiitaPostListView: QiitaPostListView? { get set }
    var page: Int { get set }
    func start()
    func listPosts()
    func listPosts(query: String?)
    func openArticle(post: QiitaPost)
    func search(query: String)
}

class QiitaPostListPresenter: QiitaPostListPresenterType {
    var qiitaPostRepository: QiitaPostRepositoryType
    weak var qiitaPostListView: QiitaPostListView?
    var page = 1
    
    init(qiitaPostRepository: QiitaPostRepositoryType) {
        self.qiitaPostRepository = qiitaPostRepository
    }
    
    func start() {
        qiitaPostRepository.delegate = self
        if let query = qiitaPostListView?.query {
            listPosts(query: query)
        } else {
            listPosts()
        }
    }
    
    func listPosts() {
        listPosts(query: nil)
    }
    
    func listPosts(query: String?) {
        qiitaPostListView?.fetching = true
        qiitaPostRepository.fetchPosts(query: query, page: page)
    }
    
    func openArticle(post: QiitaPost) {
        qiitaPostListView?.openArticle(post)
    }
    
    func search(query: String) {
        qiitaPostListView?.showSearchResult(query: query)
    }
}

extension QiitaPostListPresenter: QiitaPostRepositoryTypeDelegate {
    func qiitaPostDataSource(_ dataSource: QiitaPostRepositoryType, didFinishFetch posts: [QiitaPost]) {
        qiitaPostListView?.showPosts(posts)
        qiitaPostListView?.fetching = false
    }
    
    func qiitaPostDataSource(_ dataSource: QiitaPostRepositoryType, didReceive error: Error) {
        qiitaPostListView?.showError(error)
    }
    
}
