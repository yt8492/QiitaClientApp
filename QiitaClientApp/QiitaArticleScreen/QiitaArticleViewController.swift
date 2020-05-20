//
//  QiitaArticleViewController.swift
//  QiitaClientApp
//
//  Created by megane on 2019/03/17.
//  Copyright © 2019 jp.nbc-uoa. All rights reserved.
//

import UIKit
import APIKit
import WebKit

class QiitaArticleViewController: UIViewController {
    private let presenter: QiitaArticlePresenterType
    private let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    private lazy var backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(QiitaArticleViewController.backButtonTapped(_:)))
    private lazy var forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(QiitaArticleViewController.forwardButtonTapped(_:)))
    private lazy var reloadButton = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(QiitaArticleViewController.reloadButtonTapped(_:)))
    private var observations: [NSKeyValueObservation] = []
    
    init(presenter: QiitaArticlePresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.qiitaArticleView = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            ])

        navigationController?.isToolbarHidden = false
        toolbarItems = [backButton, forwardButton, reloadButton]
        backButton.isEnabled = false
        forwardButton.isEnabled = false

        let goBackObservation = webView.observe(\.canGoBack, options: [.new]) { [weak self] (_, change) in
            if let newValue = change.newValue {
                DispatchQueue.main.async {
                    self?.backButton.isEnabled = newValue
                }
            }
        }
        let goForwardObservation = webView.observe(\.canGoForward, options: [.new]) { [weak self] (_, change) in
            if let newValue = change.newValue {
                DispatchQueue.main.async {
                    self?.forwardButton.isEnabled = newValue
                }
            }
        }
        let titleObservation = webView.observe(\.title, options: [.new]) { [weak self] (_, change) in
            if let newValue = change.newValue {
                DispatchQueue.main.async {
                    self?.title = newValue
                }
            }
        }
        observations = [goBackObservation, goForwardObservation, titleObservation]

        presenter.start()
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        presenter.pageGoBack()
    }
    
    @objc func forwardButtonTapped(_ sender: UIBarButtonItem) {
        presenter.pageGoForward()
    }
    
    @objc func reloadButtonTapped(_ sender: UIBarButtonItem) {
        presenter.pageReload()
    }
}

extension QiitaArticleViewController: QiitaArticleView {
    func showArticle(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func showBackPage() {
        webView.goBack()
    }
    
    func showForwardPage() {
        webView.goForward()
    }
    
    func showReloadPage() {
        webView.reload()
    }
}
