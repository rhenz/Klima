//
//  DayViewController.swift
//  Klima
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

final class DayViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = .green
    }

}
