//
//  QiitaMyPageViewController.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/18.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import UIKit
import Kingfisher

class QiitaMyPageViewController: UIViewController {
    
    let presenter: QiitaMyPagePresenterType
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var websiteUrlLabel: UILabel!
    
    init(presenter: QiitaMyPagePresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.qiitaMyPageView = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.start()
    }
}

extension QiitaMyPageViewController: QiitaMyPageView {
    func login() {
        
    }
    
    func showMyPage(user: QiitaAuthedUser) {
        if let imageUrl = user.profileImageUrl {
            iconImageView.kf.setImage(with: imageUrl)
        }
        idLabel.text = user.id
        if let userName = user.name {
            nameLabel.text = userName
        } else {
            nameLabel.isHidden = true
        }
        if let organization = user.organization {
            organizationLabel.text = organization
        } else {
            organizationLabel.isHidden = true
        }
        if let description = user.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
        }
        if let websiteUrl = user.websiteUrl {
            websiteUrlLabel.text = websiteUrl.absoluteString
        } else {
            descriptionLabel.isHidden = true
        }
    }
    
    
}
