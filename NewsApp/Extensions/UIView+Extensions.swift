//
//  UIView+Extensions.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import UIKit

extension UIView  {
    @IBInspectable
       var cornerRadius: CGFloat {
           get {
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
               layer.masksToBounds = newValue > 0
           }
       }
}
