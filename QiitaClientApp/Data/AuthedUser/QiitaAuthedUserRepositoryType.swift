//
//  QiitaAuthedUserRepositoryType.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

protocol QiitaAuthedUserRepositoryTypeDelegate: AnyObject {
    func qiitaAuthedUserRepository(_ repository: QiitaAuthedUserRepositoryType, didFinishFetch authedUser: QiitaAuthedUser)
    func qiitaAuthedUserRepository(_ repository: QiitaAuthedUserRepositoryType, didReceive error: Error)
}

protocol QiitaAuthedUserRepositoryType: AnyObject {
    var delegate: QiitaAuthedUserRepositoryTypeDelegate? { get set }
    func fetchUser(loginToken: String)
}
