//
//  TopViewController.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import UIKit

class QiitaPostListViewController: UIViewController {
    private let presenter: QiitaPostListPresenterType
    var fetching = false
    private var posts: [QiitaPost] = []
    let query: String?
    @IBOutlet weak var tableView: UITableView!
    
    init(presenter: QiitaPostListPresenterType, query: String? = nil) {
        self.presenter = presenter
        self.query = query
        super.init(nibName: nil, bundle: nil)
        self.presenter.qiitaPostListView = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let navigationBarFrame = navigationController?.navigationBar.bounds else {
            return
        }
        let searchBar = UISearchBar(frame: navigationBarFrame)
        searchBar.delegate = self
        searchBar.placeholder = "絞り込み"
        searchBar.keyboardType = UIKeyboardType.default
        navigationItem.titleView = searchBar
        navigationItem.titleView?.frame = searchBar.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.nib, forCellReuseIdentifier: PostCell.identifier)
        presenter.start()
    }
}

extension QiitaPostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell else {
            fatalError("error at row \(indexPath.row)")
        }

        let post = posts[indexPath.row]
        cell.configure(with: post)

        return cell
    }
}

extension QiitaPostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        // 余裕があったらWebviewでpost.urlを表示する
        let post = posts[indexPath.row]
        openArticle(post)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        guard distanceToBottom <= 0, !fetching else { return }
        presenter.page += 1
        presenter.listPosts(query: query)
    }
}

extension QiitaPostListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            presenter.search(query: query)
        }
    }
}

extension QiitaPostListViewController: QiitaPostListView {
    func showPosts(_ posts: [QiitaPost]) {
        self.posts += posts
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showSearchResult(query: String) {
        let qiitaPostRepository = QiitaPostRepository.shared
        let qiitaPostListPresenter = QiitaPostListPresenter(qiitaPostRepository: qiitaPostRepository)
        let qiitaPostListViewController = QiitaPostListViewController(presenter: qiitaPostListPresenter, query: query)
        qiitaPostListPresenter.qiitaPostListView = qiitaPostListViewController
        navigationController?.pushViewController(qiitaPostListViewController, animated: true)
    }
    
    func showError(_ error: Error) {
        
    }
    
    func openArticle(_ post: QiitaPost) {
        let qiitaArticlePresenter = QiitaArticlePresenter(url: post.url)
        let qiitaArticleViewController = QiitaArticleViewController(presenter: qiitaArticlePresenter)
        navigationController?.pushViewController(qiitaArticleViewController, animated: true)
    }
}
