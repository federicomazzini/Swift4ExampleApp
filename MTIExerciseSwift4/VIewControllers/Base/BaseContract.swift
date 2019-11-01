//
//  BaseContract.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation

protocol BaseContractPresenter {
    var baseView: BaseContractView! { get }
    func loadView()
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func onDestroy()
}

protocol BaseContractView: class {
    var basePresenter: BaseContractPresenter! { get }
    func injectDependencies()
    func showError(error: Error)
    func showForegroundProgress()
    func hideForegroundProgress()
}
