//
//  ViewController.swift
//  Swither
//
//  Created by David Ferreira Lima on 25/11/24.
//

import UIKit
import Toast

class ViewController: UIViewController {
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }() //backgroundView receive a UIImageView without frame rect
    
    private lazy var topCardView: WeatherCardView = {
        let view = WeatherCardView()
        return view
    }()
    
    private lazy var humidityWindCardStackView: HumidityWindCardStackView = {
        let card = HumidityWindCardStackView()
        return card
    }()
    
    private lazy var dayWeatherCollectionView: DayWeatherCollectionView = {
        let collectionView = DayWeatherCollectionView()
        return collectionView
    }()
    
    private lazy var dayWeatherTableView: DayWeatherTableView = {
        let tableView = DayWeatherTableView()
        return tableView
    }()
    
    private lazy var hourWeatherSection: WeatherSectionStackView = {
        let section = WeatherSectionStackView(label: "PREVISÕES DO DIA", child: dayWeatherCollectionView)
        return section
    }()
    
    private lazy var dayWeatherSection: WeatherSectionStackView = {
        let section = WeatherSectionStackView(label: "PRÓXIMOS DIAS", child: dayWeatherTableView)
        return section
    }()
    
    private let service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (service.apiKey.isEmpty) {
            self.view.makeToast("No such API key", duration: 3.0, position: .bottom)
        }
        
        setupView()
        
        LocationService.shared.getCityName { [weak self] city in
            
            guard let self = self else {return}
            
            guard let city = city else {
                self.view.makeToast("Location not found", duration: 3.0, position: .bottom)
                return
            }
            
            self.service.fetchData(city: city) { [weak self] data in
                guard let self = self else {return}
                
                if let data = data {
                    print(String(describing: data))
                } else {
                    self.view.makeToast("Can't fetch data", duration: 3.0, position: .bottom)
                }
            }
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() { //method to define the hierarchy of views into the ViewController
        view.addSubview(backgroundView)
        view.addSubview(topCardView)
        view.addSubview(humidityWindCardStackView)
        view.addSubview(hourWeatherSection)
        view.addSubview(dayWeatherSection)
    }
    
    private func setConstraints() { //method to define constraints
        NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                topCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                topCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
                topCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
                topCardView.heightAnchor.constraint(equalToConstant: 169)
            ])
            
            NSLayoutConstraint.activate([
                humidityWindCardStackView.widthAnchor.constraint(equalToConstant: 206),
                humidityWindCardStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                humidityWindCardStackView.topAnchor.constraint(equalTo: topCardView.bottomAnchor, constant: 24)
            ])
            
            // Constraints for the hourWeatherSection (stack view)
            NSLayoutConstraint.activate([
                hourWeatherSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hourWeatherSection.topAnchor.constraint(equalTo: humidityWindCardStackView.bottomAnchor, constant: 30),
                hourWeatherSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
                hourWeatherSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
            ])
            
            // Constraints for the dayWeatherSection (stack view)
            NSLayoutConstraint.activate([
                dayWeatherSection.topAnchor.constraint(equalTo: hourWeatherSection.bottomAnchor, constant: 32),
                dayWeatherSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
                dayWeatherSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
            ])
            
            NSLayoutConstraint.activate([
                dayWeatherCollectionView.heightAnchor.constraint(equalToConstant: 84)
            ])
            
            NSLayoutConstraint.activate([
                dayWeatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

