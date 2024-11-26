//
//  HumidityWindCard.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//
import UIKit

class HumidityWindCard: UIStackView {
    init(){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 3
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(named: "white600")
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        setupView()
    }
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var humidityLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "Umidade")
        return label
    }()
    
    private lazy var humidityValueLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "1000mm")
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var windLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "Vento")
        return label
    }()
    
    private lazy var windValueLabel: HumidityWindLabel = {
        let label = HumidityWindLabel(text: "10Km/h")
        return label
    }()
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addArrangedSubview(humidityStackView)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityValueLabel)
        self.addArrangedSubview(windStackView)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windValueLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            humidityStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
