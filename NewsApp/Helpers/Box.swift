//
//  Box.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

/// Box is type for emmiting values to listeners
final class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
    
    func accept(_ value: T) {
        self.value = value
        listener?(value)
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
