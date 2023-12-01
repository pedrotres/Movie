//
//  UITableViewCell+Extensions.swift
//  Movie
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import UIKit

extension UITableViewCell {

    class func classIdentifier() -> String {
        guard let className = String(describing: self).components(separatedBy: ".").last else {
            return ""
        }

        return className
    }
}
