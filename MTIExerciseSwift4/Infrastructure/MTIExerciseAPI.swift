//
//  MTIExerciseAPI.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Alamofire
import PromiseKit

class MTIExerciseAPIError: Error {
    
    var code: ErrorCodeType

    enum ErrorCodeType: Int {
        case decoding = 101
        case network  = 102
    }
    
    init(code: ErrorCodeType) {
        self.code = code
    }
}

class MTIExerciseAPI {

    public enum Environment: String {
        case development = "http://private-f0eea-mobilegllatam.apiary-mock.com/list"
    }

    private let environment: Environment
    internal var sessionManager: SessionManager!
    internal let baseURL: URL

    init(environment: Environment) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest  = 10 // seconds
        configuration.timeoutIntervalForResource = 10 //seconds
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)

        self.environment = environment
        self.baseURL = URL(string: self.environment.rawValue)!
        print("Environement setted: \(environment.rawValue)")
    }
    
}

extension MTIExerciseAPI {
    
    func downloadLaptops() -> Promise<LaptopList> {
        return Promise<LaptopList> { seal in
            sessionManager.request(baseURL).responseJSON() { response in
                guard let data = response.data else {
                    let error = MTIExerciseAPIError(code: .network)
                    seal.reject(error)
                    return
                }
                
//                print(String(data: data, encoding: String.Encoding.utf8) ?? "Error encoding JSON as String")
                
                do {
                    let laptopList = try JSONDecoder().decode(LaptopList.self, from: data)
                    seal.fulfill(laptopList)
                } catch {
                    let error = MTIExerciseAPIError(code: .decoding)
                    seal.reject(error)
                }
            }
        }
    }
    
}
