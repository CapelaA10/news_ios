//
//  Extensions.swift
//  News
//
//  Created by Pedro Capela on 28/05/2021.
//

import Foundation

extension String{
    func localized() -> String{
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
