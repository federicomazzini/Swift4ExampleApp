//
//  BaseViewController.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController, BaseContractView {

    // MARK: - Presenter

    internal var basePresenter: BaseContractPresenter!

    // MARK: - Properties

    internal var progressView: MBProgressHUD!
    
    internal var scrollView: UIScrollView?
    
    // MARK: - Lifecycle

    deinit { }

    override func loadView() {
        super.loadView()
        injectDependencies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        basePresenter.viewDidLoad()
        configureProgressView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basePresenter.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        basePresenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        basePresenter.viewWillDisappear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        basePresenter.viewDidDisappear()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    // MARK: - BaseContractView
    
    func showError(error: Error) {
        
    }

    // Override this method in all BaseViewController's childs
    func injectDependencies() {
        basePresenter = Configurator.getBasePresenter(viewController: self)
    }

    func showError() {
//        showSimpleAlert()
    }
    
    func showForegroundProgress() {
        DispatchQueue.main.async {
            self.progressView.show(animated: true)
        }
    }
    
    func showForegroundProgress(withTitle title: String) {
        DispatchQueue.main.async {
            self.progressView.label.text = title
            self.progressView.show(animated: true)
        }
    }
    
    func hideForegroundProgress() {
        DispatchQueue.main.async {
            self.progressView.label.text = ""
            self.progressView.hide(animated: true)
        }
    }
    
    func changeForegroundProgress(title: String) {
        self.progressView.label.text = title
    }

    // MARK: - Private

    private func configureProgressView() {
        progressView = MBProgressHUD()
        progressView.backgroundView.style = .solidColor
        progressView.backgroundView.color = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        progressView.bezelView.backgroundColor = UIColor.gray
        progressView.isUserInteractionEnabled = true // true blocks interaction
        progressView.add(to: self.view)
    }

}
