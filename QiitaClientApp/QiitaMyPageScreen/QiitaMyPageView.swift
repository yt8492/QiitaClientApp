//
//  QiitaMyPageView.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

protocol QiitaMyPageView: AnyObject {
    func login()
    func showMyPage(user: QiitaAuthedUser)
}
