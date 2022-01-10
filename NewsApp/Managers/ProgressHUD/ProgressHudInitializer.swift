//
//  ProgressHudInitializer.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation
import ProgressHUD

class ProgressHUDManager : ManagerInitializer {
    
    func initialize() {
        ProgressHUD.animationType = .horizontalCirclesPulse
    }
}
