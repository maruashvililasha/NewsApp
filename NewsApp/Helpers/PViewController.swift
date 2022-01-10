//
//  NViewController.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import UIKit

public protocol Storyboarded {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension Storyboarded {
    public static var storyboardName: String { String(describing: self) }
    public static var storyboardIdentifier: String { String(describing: self) }
}

extension Storyboarded where Self: UIViewController {
    public static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(identifier: "com.maruashvililasha.Processica-Movies"))
        guard let viewController: Self
            = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
                as? Self else {
                    fatalError("Failed to instantiate view controller \(storyboardIdentifier)"
                        + " from storyboard \(storyboardName)")
        }
        return viewController
    }
}

public class NViewController: UIViewController, Storyboarded {
    
}
