//
//  WeekViewController.swift
//  Klima
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

protocol WeekDayRepresentable {
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
}

protocol WeekViewControllerDelegate: AnyObject {
    func controllerDidRefresh(_ controller: WeekViewController)
}

final class WeekViewController: UIViewController {
    // MARK: - Properties
    var viewModel: WeekViewModel? {
        didSet {
            // Hide Refresh Control
            refreshControl.endRefreshing()
            
            if let viewModel = viewModel {
                // Setup View Model
                setupViewModel(with: viewModel)
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()
        
        // Configure Refresh Control
        refreshControl.tintColor = Styles.Colors.baseTintColor
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    weak var delegate: WeekViewControllerDelegate?
    
    // MARK: -
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
            
            // Set Refresh Control
            tableView.refreshControl = refreshControl
        }
    }
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
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
        view.backgroundColor = .systemBackground
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        // Hide Activity Indicator View
        activityIndicator.stopAnimating()
        
        // Update Table View
        tableView.reloadData()
        tableView.isHidden = false
    }
}

// MARK: - Table View Data Source
extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.cellIdentifier, for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to Dequeue Week Day Table View Cell")
        }
        
        // Configure Cell
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        cell.configure(with: viewModel.viewModel(for: indexPath.item))
        
        return cell
    }
}

// MARK: - Actions
extension WeekViewController {
    @objc private func refresh(_ sender: UIRefreshControl) {
        // Notify Delegate
        delegate?.controllerDidRefresh(self)
    }
}
