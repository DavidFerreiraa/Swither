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
        let label = HumidityWindLabel(text: "TER")
        return label
    }()
    
    private lazy var minTemperatureLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "min 20")
        return label
    }()
    
    private lazy var maxTemperatureLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "max 20")
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cloud-icon")
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
        return stackView
    }()
    
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
        stackView.setConstraintsToParent(contentView)
        NSLayoutConstraint.activate([
            dayOfTheWeekLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 48)
        ])
    }
}
