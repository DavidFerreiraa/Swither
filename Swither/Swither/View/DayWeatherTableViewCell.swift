//
//  DayWeatherTableViewCell.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {
    
    static let identifier: String = "DayWeatherTableCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dayOfTheWeekLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "")
        return label
    }()
    
    private lazy var minTemperatureLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "")
        return label
    }()
    
    private lazy var maxTemperatureLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "")
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayOfTheWeekLabel, weatherIcon, minTemperatureLabel, maxTemperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32)
        stackView.spacing = 15
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    func loadData(iconUrl: URL?, min: String, max: String, weekDay: String) {
        dayOfTheWeekLabel.text = weekDay
        minTemperatureLabel.text = "min \(min)"
        maxTemperatureLabel.text = "max \(max)"
        // Check if the iconUrl is valid
        if let url = iconUrl {
            weatherIcon.load(url: url) // Load the image from the URL
        } else {
            weatherIcon.image = UIImage(named: "cloud-icon") // Set the default image
        }
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfTheWeekLabel.widthAnchor.constraint(equalToConstant: 32),
            weatherIcon.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
