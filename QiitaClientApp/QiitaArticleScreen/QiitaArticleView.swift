//
//  QiitaArticleView.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit

protocol QiitaArticleView: AnyObject {
    func showArticle(url: URL)
    func showBackPage()
    func showForwardPage()
    func showReloadPage()
}
