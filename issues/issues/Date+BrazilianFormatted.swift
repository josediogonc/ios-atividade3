//
//  UIViewController+Context.swift
//  issues
//
//  Created by user225450 on 7/28/22.
//

import UIKit
import CoreData

extension Date {
    var brazilianFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
