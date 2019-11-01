//
//  LaptopsRepository.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation
import PromiseKit

protocol LaptopsRepository {
    func downloadLaptops() -> Promise<LaptopList>
}

class LaptopsRepositoryImplementation: LaptopsRepository {
    internal let api: MTIExerciseAPI!
    
    init(api: MTIExerciseAPI) {
        self.api = api
    }
    
    func downloadLaptops() -> Promise<LaptopList> {
        return self.api.downloadLaptops()
    }
    
}
