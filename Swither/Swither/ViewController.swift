//
//  ViewController.swift
//  Swither
//
//  Created by David Ferreira Lima on 25/11/24.
//

import UIKit
import Toast
import SkeletonView

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
        view.isSkeletonable = true
        view.skeletonCornerRadius = 20
        return view
    }()
    
    private lazy var humidityWindCardStackView: HumidityWindCardStackView = {
        let card = HumidityWindCardStackView()
        card.isSkeletonable = true
        card.skeletonCornerRadius = 20
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
        section.isSkeletonable = true
        section.skeletonCornerRadius = 20
        return section
    }()
    
    private lazy var dayWeatherSection: WeatherSectionStackView = {
        let section = WeatherSectionStackView(label: "PRÓXIMOS DIAS", child: dayWeatherTableView)
        section.isSkeletonable = true
        section.skeletonCornerRadius = 20
        return section
    }()
    
    private let service = Service()
    private var forecastResponse: OpenWeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (service.apiKey.isEmpty) {
            self.view.makeToast("No such API key", duration: 3.0, position: .bottom)
        }
        
        service.fetchDataByCurrentLocation {
            (city, response) in
            guard let response else {
                self.view.makeToast("Can't fetch data", duration: 3.0, position: .bottom)
                return
            }
            
            guard let city else {
                self.view.makeToast("Can't fetch data", duration: 3.0, position: .bottom)
                return
            }
            
            DispatchQueue.main.async {
                self.loadData(city: city, response: response)
            }
        }
        
        setupView()
    }
    
    private func loadData(city: City, response: OpenWeatherResponse) {
        // Ensure UI updates happen on the main thread
        self.topCardView.cityName = city.name
        self.topCardView.temperature = response.current.temp.tempToString()
        self.humidityWindCardStackView.humidity = response.current.humidity.humidityToString()
        self.humidityWindCardStackView.wind = response.current.windSpeed.windSpeedToString()
        self.dayWeatherCollectionView.data = response.hourly
        self.dayWeatherTableView.data = response.daily
        
        self.dayWeatherCollectionView.reloadData()
        self.dayWeatherTableView.reloadData()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSkeletonState), name: .didChangeLoadingState, object: nil)
        
        // initial skeleton state
        updateSkeletonState()
    }
    
    @objc private func updateSkeletonState() {
        if Shared.shared.isLoading {
            topCardView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
            humidityWindCardStackView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
            dayWeatherSection.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
            hourWeatherSection.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.topCardView.hideSkeleton()
                self.humidityWindCardStackView.hideSkeleton()
                self.dayWeatherSection.hideSkeleton()
                self.hourWeatherSection.hideSkeleton()
            }
        }
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

