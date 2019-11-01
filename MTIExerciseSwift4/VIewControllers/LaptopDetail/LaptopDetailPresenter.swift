//
//  LaptopDetailPresenter.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 01/11/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireImage

// Presenter Protocol
protocol LaptopDetailContractPresenter: BaseContractPresenter {
    var item: Item? { get }
    
    func getImageFor(_ item: Item) -> Promise<Data>
}

// View Controller Protocol
protocol LaptopDetailContractView: BaseContractView {
    var presenter: LaptopDetailContractPresenter! { get }
}

// Presenter Implementation
class LaptopDetailPresenter: BasePresenter, LaptopDetailContractPresenter {
    var view: LaptopDetailContractView!
    var item: Item?
    
    init(view: LaptopDetailViewController) {
        self.view = view
        super.init(view: view)
    }
    
    func getImageFor(_ item: Item) -> Promise<Data> {
        return Promise<Data> { seal in
            Alamofire.request(item.imgUrlString ?? "").responseImage { response in
                if let image = response.result.value, let data = image.pngData() {
                    seal.fulfill(data)
                } else {
                    let err = MTIExerciseAPIError(code: .network)
                    print(err)
                    seal.reject(err)
                }
            }
        }
    }
    
}
