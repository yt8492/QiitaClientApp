//
//  QiitaArticlePresenter.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

protocol QiitaArticlePresenterType: AnyObject {
    var qiitaArticleView: QiitaArticleView? { get set }
    var url: URL { get }
    func start()
    func show()
    func pageGoBack()
    func pageGoForward()
    func pageReload()
}

class QiitaArticlePresenter: QiitaArticlePresenterType {
    weak var qiitaArticleView: QiitaArticleView?
    var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func start() {
        show()
    }
    
    func show() {
        qiitaArticleView?.showArticle(url: url)
    }
    
    func pageGoBack() {
        qiitaArticleView?.showBackPage()
    }
    
    func pageGoForward() {
        qiitaArticleView?.showForwardPage()
    }
    
    func pageReload() {
        qiitaArticleView?.showReloadPage()
    }
}
