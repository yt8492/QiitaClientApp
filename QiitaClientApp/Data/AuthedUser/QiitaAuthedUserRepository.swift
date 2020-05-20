//
//  QiitaAuthedUserRepository.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import Foundation
import APIKit
import Result

class QiitaAuthedUserRepository: QiitaAuthedUserRepositoryType {
    var delegate: QiitaAuthedUserRepositoryTypeDelegate?
    private let session = Session.shared
    
    func fetchUser(loginToken: String) {
        let request = AuthedUserRequest(loginToken: loginToken)
        session.send(request) { [weak self] result in
            guard let me = self else {
                return
            }
            switch result {
            case .success(let value):
                me.delegate?.qiitaAuthedUserRepository(me, didFinishFetch: value)
            case .failure(let error):
                me.delegate?.qiitaAuthedUserRepository(me, didReceive: error)
            }
        }
    }
}
