//
//  ViewController.swift
//  Swither
//
//  Created by David Ferreira Lima on 25/11/24.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
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
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor), //creates a constraint on top of the customView with 100 of distance from the safe area
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor), //creates a constraint on right of the customView with 100 of distance from the safe area
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor), //creates a constraint on left of the customView with 100 of distance from the safe area
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]) //Creating the constraints for the customView
        
        NSLayoutConstraint.activate([
            topCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            topCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            topCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            topCardView.heightAnchor.constraint(equalToConstant: 169)
        ]) //Creating the constraints for the topCardView
        
        NSLayoutConstraint.activate([
            humidityWindCardStackView.widthAnchor.constraint(equalToConstant: 206),
            humidityWindCardStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            humidityWindCardStackView.topAnchor.constraint(equalTo: topCardView.bottomAnchor, constant: 24)
        ]) //Creating the constraints for the humidityWindCardStackView
        
        NSLayoutConstraint.activate([
            hourWeatherSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourWeatherSection.topAnchor.constraint(equalTo: humidityWindCardStackView.bottomAnchor, constant: 30),
            hourWeatherSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            hourWeatherSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
        ]) //Creating the constraints for the hourWeatherSection
        
        NSLayoutConstraint.activate([
            dayWeatherCollectionView.heightAnchor.constraint(equalToConstant: 84),
            dayWeatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dayWeatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]) //Creating the constraints for the dayWeatherCollectionView
        
        NSLayoutConstraint.activate([
            dayWeatherSection.topAnchor.constraint(equalTo: dayWeatherCollectionView.bottomAnchor, constant: 32),
            dayWeatherSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            dayWeatherSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ]) //Creating the constraints for the dayWeatherSection
        
        NSLayoutConstraint.activate([
            dayWeatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dayWeatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dayWeatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

