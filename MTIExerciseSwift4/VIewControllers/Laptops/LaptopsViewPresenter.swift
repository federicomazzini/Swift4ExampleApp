//
//  LaptopsViewPresenter.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 01/11/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation
import PromiseKit

// Presenter Protocol
protocol LaptopsViewContractPresenter: BaseContractPresenter {
    var repository: LaptopsRepository! { get }
    
    var laptopList: [Item]? { get }
}

// View Controller Protocol
protocol LaptopsViewContractView: BaseContractView {
    var presenter: LaptopsViewContractPresenter! { get }
    
    func reloadTable()
    func showLoadingOverlay()
    func hideLoadingOverlay()
}

// Presenter Implementation
class LaptopsViewPresenter: BasePresenter, LaptopsViewContractPresenter {
    var view: LaptopsViewContractView!
    var repository: LaptopsRepository!
    var laptopList: [Item]?
    
    init(repository: LaptopsRepository, view: LaptopsViewController) {
        self.view = view
        self.repository = repository
        
        super.init(view: view)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        getLaptops()
    }
    
    private func getLaptops() {
        view.showLoadingOverlay()
        self.repository.downloadLaptops().done { laptops in
            self.laptopList = laptops.list
            self.view.reloadTable()
            self.view.hideLoadingOverlay()
        }.catch { error in
            print(error)
            self.view.hideLoadingOverlay()
        }
    }
    
}
