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
    
    private lazy var topCardView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel() // infer the frame as .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20) //or you can just .systemFont(...) it will works as well
        label.text = "São Paulo"
        label.textAlignment = .center
        label.textColor = UIColor(named: "blue-primary")
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.text = "27ºC"
        label.textAlignment = .left
        label.textColor = UIColor(named: "blue-primary")
        return label
    }()
    
    private lazy var sunImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sun-icon")
        imageView.contentMode = .scaleAspectFit //respect the proportions but won't crop the image
        return imageView
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
        
        topCardView.addSubview(cityLabel)
        topCardView.addSubview(temperatureLabel)
        topCardView.addSubview(sunImage)
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
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.topAnchor.constraint(equalTo: topCardView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: topCardView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: topCardView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 21),
            temperatureLabel.leadingAnchor.constraint(equalTo: topCardView.leadingAnchor, constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            sunImage.heightAnchor.constraint(equalToConstant: 86),
            sunImage.widthAnchor.constraint(equalToConstant: 86),
            sunImage.trailingAnchor.constraint(equalTo: topCardView.trailingAnchor, constant: -26),
            sunImage.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            sunImage.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15)
        ])
    }
}

