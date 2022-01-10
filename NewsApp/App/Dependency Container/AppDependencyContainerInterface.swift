//
//  AppDependencyContainerInterface.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation
import Core

protocol AppDependencyContainerInterface {
    // Movie List
    func newsDependencies() -> NewsViewModel
}
