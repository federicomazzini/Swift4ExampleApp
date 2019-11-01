//
//  Configurator.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation

// This class is the Dependecy Injection manager.
// It takes care of initializing all Presenters, Repositories and even the API classes.
// Avoiding singletons when necessary.
class Configurator {

    // Environment for our APIs
    static let environment: MTIExerciseAPI.Environment = .development
    
    static var projectAPI: MTIExerciseAPI?
    
    static var laptopsRepository: LaptopsRepository?

    // MARK: - Presenter Classes

    class func getBasePresenter(viewController: BaseContractView) -> BaseContractPresenter {
        return BasePresenter(view: viewController)
    }
    
    class func getLaptopsViewPresenter(viewController: LaptopsViewController) -> LaptopsViewPresenter {
        return LaptopsViewPresenter(repository: getLaptopsRepository(), view: viewController)
    }
    
    class func getLaptopDetailPresenter(viewController: LaptopDetailViewController) -> LaptopDetailPresenter {
        return LaptopDetailPresenter( view: viewController)
    }

    // MARK: - Repositories Classes
    
    class func getLaptopsRepository() -> LaptopsRepository {
        if laptopsRepository == nil {
            laptopsRepository = LaptopsRepositoryImplementation(api: getMTIExerciseAPI())
        }
        return laptopsRepository!
    }
    
    // MARK: - Infrastructure Classes

    class func getMTIExerciseAPI() -> MTIExerciseAPI {
        if projectAPI == nil {
            projectAPI = MTIExerciseAPI(environment: environment)
        }
        return projectAPI!
    }

}
