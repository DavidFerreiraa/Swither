//
//  WeatherCardView.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//
import UIKit

class WeatherCardView: UIView {
    // Properties for city and temperature
    var cityName: String = "" {
        didSet {
            cityLabel.text = cityName
        }
    }
    
    var temperature: String = "" {
        didSet {
            temperatureLabel.text = temperature
        }
    }
    
    // Custom initializer
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "white-primary")
        self.layer.cornerRadius = 20
        setupView()
    }
    
    // Required initializer for decoding (e.g., storyboards or nibs)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel() // infer the frame as .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20) //or you can just .systemFont(...) it will works as well
        label.textAlignment = .center
        label.textColor = UIColor(named: "blue-primary")
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.textAlignment = .left
        label.textColor = .blue100
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sun-icon")
        imageView.contentMode = .scaleAspectFit //respect the proportions but won't crop the image
        return imageView
    }()
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubview(cityLabel)
        self.addSubview(temperatureLabel)
        self.addSubview(weatherImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 21),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.heightAnchor.constraint(equalToConstant: 86),
            weatherImage.widthAnchor.constraint(equalToConstant: 86),
            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            weatherImage.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15)
        ])
    }
}
