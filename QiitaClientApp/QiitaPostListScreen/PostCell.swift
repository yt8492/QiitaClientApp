//
//  PostCell.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.kf.cancelDownloadTask()
    }

    func configure(with post: QiitaPost) {
        postTitleLabel.text = post.title
        postBodyLabel.text = post.body
        createdAtLabel.text = "\(post.user.id)が\(post.createdAtString)に投稿"
        if let url = post.user.profileImageURL {
            iconImageView.kf.setImage(with: url)
        }
    }
    
}
