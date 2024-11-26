//
//  DayWeatherCollectionViewCell.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import UIKit

class DayWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "DayWeather"
    
    private lazy var cellCard: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hourLabel, weatherImageView, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.gray600?.cgColor
        stackView.layer.cornerRadius = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private lazy var hourLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(
            text: "12:00",
            font: .systemFont(ofSize: 10, weight: .semibold))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var temperatureLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(
            text: "30ºC",
            font: .systemFont(ofSize: 14, weight: .semibold))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sun-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubview(cellCard)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cellCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
