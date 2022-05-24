//
//  RootViewController.swift
//  Klima
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
        case notAuthorizedToRequestLocation
        case noWeatherDataAvailable
        case failedToRequestLocation
    }
    
    // MARK: - Properties
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // Setup View Model
            DispatchQueue.global(qos: .userInitiated).async {
                self.setupViewModel(with: viewModel)
            }
        }
    }
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(identifier: DayViewController.storyboardIdentifier) as? DayViewController else {
            fatalError("Unable to Instantiate Day View Controller")
        }
        
        // Configure Day View Controller
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return dayViewController
    }()
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(identifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
            fatalError("Unable to Instantiate Day View Controller")
        }
        
        // Configure Day View Controller
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return weekViewController
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods
    private func setupChildViewControllers() {
        addChild(dayViewController)
        addChild(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        NSLayoutConstraint.activate([
            // Configure Day View
            dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // Configure Week View
            weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor),
            weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Notify Child View Controller
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchWeatherData = { [weak self] (result) in
            switch result {
            case .success(let weatherData):                
                // Initialize Day View Model
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                
                // Update Day View Controller
                self?.dayViewController.viewModel = dayViewModel
                
                // Initialize Week View Model
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                // Update Week View Controller
                self?.weekViewController.viewModel = weekViewModel
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self?.presentAlert(for: error)
            }
        }
    }
    
    private func presentAlert(for error: WeatherResponseError) {
        let ac = UIAlertController(title: error.alertTitleAndMessage().title, message: error.alertTitleAndMessage().message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true)
    }
}


extension RootViewController {
    
}
