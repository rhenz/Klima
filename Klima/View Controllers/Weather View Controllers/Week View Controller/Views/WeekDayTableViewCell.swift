//
//  WeekDayTableViewCell.swift
//  Klima
//
//  Created by John Salvador on 5/19/22.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Properties
    @IBOutlet var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = Styles.Colors.baseTextColor
            dayLabel.font = Styles.Fonts.heavyLarge
        }
    }
    
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .black
            dateLabel.font = Styles.Fonts.lightRegular
        }
    }
    
    @IBOutlet var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.textColor = .black
            windSpeedLabel.font = Styles.Fonts.lightSmall
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = .black
            temperatureLabel.font = Styles.Fonts.lightSmall
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = Styles.Colors.baseTintColor
        }
    }
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - 
    func configure(with representable: WeekDayRepresentable) {
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        iconImageView.image = representable.image
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
    }
}
