//
//  UIViewController.swift
//  Klima
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

extension UIViewController {
    // MARK: - Static Properties
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
