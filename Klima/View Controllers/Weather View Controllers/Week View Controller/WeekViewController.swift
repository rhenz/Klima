//
//  WeekViewController.swift
//  Klima
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

final class WeekViewController: UIViewController {
    // MARK: - Properties
    var viewModel: WeekViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = .red
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
//        print(viewModel)
    }
}
