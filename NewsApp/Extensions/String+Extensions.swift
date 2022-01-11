//
//  String+Extensions.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

extension String {
    func prettyPrinted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return "N/A"
        }
        dateFormatter.dateFormat = "HH:mm, MMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
