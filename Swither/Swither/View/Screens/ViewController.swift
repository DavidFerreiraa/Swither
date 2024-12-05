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
    private let viewModel = WeatherViewModel()
    
    // MARK: SkeletonViews for the application
    private lazy var hourWeatherSectionSkeletonView: UIView = {
        return UIView().skeleton()
    }()
    
    private lazy var dayWeatherSectionSkeletonView: UIView = {
        return UIView().skeleton()
    }()
    
    private lazy var topCardSkeletonView: UIView = {
        return UIView().skeleton()
    }()
    
    private lazy var humidityWindCardStackSkeletonView: UIView = {
        return UIView().skeleton(cornerRadius:10)
    }()
    
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
        setupView()
    }
    
    private func fetchWeatherData(completion: @escaping () -> Void) {
        viewModel.fetchWeatherData { [weak self] error in
            guard let self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.view.makeToast(error, duration: 3.0, position: .bottom)
                }
            } else {
                completion()
            }
        }
    }
    
    private func loadData() {
        topCardView.cityName = viewModel.cityName
        topCardView.temperature = viewModel.temperature
        humidityWindCardStackView.humidity = viewModel.humidity
        humidityWindCardStackView.wind = viewModel.wind
        dayWeatherCollectionView.data = viewModel.hourlyForecast
        dayWeatherTableView.data = viewModel.dailyForecast
        
        dayWeatherCollectionView.reloadData()
        dayWeatherTableView.reloadData()
    }
    
    private func setupView() {
        setupSkeletonView()
        fetchWeatherData() {
            DispatchQueue.main.async {
                self.setHierarchy()
                self.setConstraints()
                self.loadData()
            }
        }
    }
    
    private func setupSkeletonView() {
        setSkeletonHierarchy()
        setSkeletonConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSkeletonState), name: .didChangeLoadingState, object: nil)
        
        // initial skeleton state
        updateSkeletonState()
    }
    
    @objc private func updateSkeletonState() {
        if viewModel.isLoading {
            DispatchQueue.main.async {
                self.topCardSkeletonView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
                self.humidityWindCardStackSkeletonView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
                self.dayWeatherSectionSkeletonView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
                self.hourWeatherSectionSkeletonView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.2))
            }
        } else {
            DispatchQueue.main.async {
                self.topCardSkeletonView.hideSkeleton()
                self.humidityWindCardStackSkeletonView.hideSkeleton()
                self.dayWeatherSectionSkeletonView.hideSkeleton()
                self.hourWeatherSectionSkeletonView.hideSkeleton()
            }
        }
    }
    
    private func setHierarchy() { //method to define the hierarchy of views into the ViewController
        view.addSubview(topCardView)
        view.addSubview(humidityWindCardStackView)
        view.addSubview(hourWeatherSection)
        view.addSubview(dayWeatherSection)
    }
    
    private func setSkeletonHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(topCardSkeletonView)
        view.addSubview(humidityWindCardStackSkeletonView)
        view.addSubview(hourWeatherSectionSkeletonView)
        view.addSubview(dayWeatherSectionSkeletonView)
    }
    
    private func setConstraints() { //method to define constraints
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
    
    private func setSkeletonConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topCardSkeletonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            topCardSkeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            topCardSkeletonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            topCardSkeletonView.heightAnchor.constraint(equalToConstant: 169)
        ])
        
        NSLayoutConstraint.activate([
            humidityWindCardStackSkeletonView.widthAnchor.constraint(equalToConstant: 206),
            humidityWindCardStackSkeletonView.heightAnchor.constraint(equalToConstant: 58),
            humidityWindCardStackSkeletonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            humidityWindCardStackSkeletonView.topAnchor.constraint(equalTo: topCardSkeletonView.bottomAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            hourWeatherSectionSkeletonView.heightAnchor.constraint(equalToConstant: 116),
            hourWeatherSectionSkeletonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourWeatherSectionSkeletonView.topAnchor.constraint(equalTo: humidityWindCardStackSkeletonView.bottomAnchor, constant: 28),
            hourWeatherSectionSkeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            hourWeatherSectionSkeletonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
        NSLayoutConstraint.activate([
            dayWeatherSectionSkeletonView.topAnchor.constraint(equalTo: hourWeatherSectionSkeletonView.bottomAnchor, constant: 32),
            dayWeatherSectionSkeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            dayWeatherSectionSkeletonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            dayWeatherSectionSkeletonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

