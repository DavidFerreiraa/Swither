//
//  WeatherSectionStackView.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//
import UIKit

class WeatherSectionStackView: UIStackView {
    // Define the label property
    private let label: String
    private let child: UIView
    
    init(label: String, child: UIView){
        self.label = label
        self.child = child
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 22
        setupView()
    }
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white100
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.text = self.label
        return label
    }()
    
    private func setupView() {
        setHierarchy()
    }
    
    private func setHierarchy() {
        self.addArrangedSubview(weatherLabel)
        self.addArrangedSubview(child)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
