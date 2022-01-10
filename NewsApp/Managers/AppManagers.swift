//
//  AppManagers.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

protocol ManagerInitializer {
    func initialize()
}

class AppManager {
    
    static let shared = AppManager()
    
    // Add more initializers to array
    var managers : [ManagerInitializer] = [
        ProgressHUDManager()
    ]
    
    public func start() {
        managers.forEach({$0.initialize()})
    }
}
