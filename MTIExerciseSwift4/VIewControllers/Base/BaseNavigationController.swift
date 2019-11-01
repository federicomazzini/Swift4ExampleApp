//
//  BaseNavigationController.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseNavigationController: UINavigationController {
    
    internal var progressView: MBProgressHUD!
    internal var dimBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProgressView()
    }
    
    private func configureProgressView() {
        dimBackgroundView = UIView(frame: view.bounds)
        dimBackgroundView.backgroundColor = UIColor.gray
        dimBackgroundView.isHidden = true
        view.addSubview(dimBackgroundView)
        
        progressView = MBProgressHUD()
        progressView.add(to: self.view)
    }
    
    func showForegroundProgress() {
        DispatchQueue.main.async {
            self.dimBackgroundView.isHidden = false
            self.progressView.show(animated: true)
        }
    }
    
    func hideForegroundProgress() {
        DispatchQueue.main.async {
            self.dimBackgroundView.isHidden = true
            self.progressView.hide(animated: true)
        }
    }
    
}
