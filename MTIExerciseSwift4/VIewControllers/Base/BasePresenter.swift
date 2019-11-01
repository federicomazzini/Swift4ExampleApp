//
//  BasePresenter.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation

class BasePresenter: BaseContractPresenter {

    internal weak var baseView: BaseContractView!

    init(view: BaseContractView) {
        self.baseView = view
    }

    func loadView() { }

    func viewDidLoad() { }

    func viewWillAppear() { }
    
    func viewDidAppear() { }

    func viewWillDisappear() { }

    func viewDidDisappear() { }

    func onDestroy() { }
}
