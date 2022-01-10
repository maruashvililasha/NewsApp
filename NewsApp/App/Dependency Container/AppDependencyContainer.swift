//
//  AppDependencyContainer.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation
import Core

class AppDependencyContainer: AppDependencyContainerInterface {
    func newsDependencies() -> NewsViewModel {
        let localDataSource = NewsLocalDataSource()
        let remoteDataSource = NewsRemoteDataSource()
        
        let dataRepo = NewsDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        
        let viewModel = NewsViewModel(dataRepo: dataRepo)
        return viewModel
    }
}
