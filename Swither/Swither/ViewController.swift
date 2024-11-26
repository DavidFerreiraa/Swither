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
    
    private lazy var topCardView: weatherCardView = {
        let view = weatherCardView()
        return view
    }()
    
    private lazy var humidityWindCard: HumidityWindCard = {
        let card = HumidityWindCard()
        return card
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
        view.addSubview(humidityWindCard)
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
            humidityWindCard.widthAnchor.constraint(equalToConstant: 206),
            humidityWindCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            humidityWindCard.topAnchor.constraint(equalTo: topCardView.bottomAnchor, constant: 24)
        ])
    }
}

