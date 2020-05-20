//
//  QiitaMyPagePresenterType.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation

protocol QiitaMyPagePresenterType: AnyObject {
    var qiitaAuthedUserRepository: QiitaAuthedUserRepositoryType { get }
    var qiitaMyPageView: QiitaMyPageView? { get set }
    func start()
    func checkLogin()
    func requestLogin()
    func show(user: QiitaAuthedUser)
}

class QiitaMyPagePresenter: QiitaMyPagePresenterType {
    let qiitaAuthedUserRepository: QiitaAuthedUserRepositoryType
    var qiitaMyPageView: QiitaMyPageView?
    
    init(qiitaAuthedUserRepository: QiitaAuthedUserRepository) {
        self.qiitaAuthedUserRepository = qiitaAuthedUserRepository
        self.qiitaAuthedUserRepository.delegate = self
    }
    
    func start() {
        checkLogin()
    }
    
    func checkLogin() {
//        if let loginToken = UserDefaults.standard.object(forKey: "LOGIN_TOKEN") as? String {
//            show()
//        }
        // TODO: ログイン処理の実装
        guard let accessToken = ProcessInfo.processInfo.environment["QIITA_TOKEN"] else {
            return
        }
        qiitaAuthedUserRepository.fetchUser(loginToken: accessToken)
        
    }
    
    func requestLogin() {
        
    }
    
    func show(user: QiitaAuthedUser) {
        qiitaMyPageView?.showMyPage(user: user)
    }

}

extension QiitaMyPagePresenter: QiitaAuthedUserRepositoryTypeDelegate {
    func qiitaAuthedUserRepository(_ repository: QiitaAuthedUserRepositoryType, didFinishFetch authedUser: QiitaAuthedUser) {
        show(user: authedUser)
    }
    
    func qiitaAuthedUserRepository(_ repository: QiitaAuthedUserRepositoryType, didReceive error: Error) {
        
    }
}
