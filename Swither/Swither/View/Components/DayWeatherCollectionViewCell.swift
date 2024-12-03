//
//  DayWeatherCollectionViewCell.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import UIKit

class DayWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "DayWeatherCollectionCell"
    
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
            text: "",
            font: .systemFont(ofSize: 10, weight: .semibold))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var temperatureLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(
            text: "",
            font: .systemFont(ofSize: 14, weight: .semibold))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func loadData(time: String, icon: UIImage?, temperature: String) {
        hourLabel.text = time
        weatherImageView.image = icon
        temperatureLabel.text = temperature
    }
    
    private func setConstraints() {
        cellCard.setConstraintsToParent(contentView)
        NSLayoutConstraint.activate([
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
