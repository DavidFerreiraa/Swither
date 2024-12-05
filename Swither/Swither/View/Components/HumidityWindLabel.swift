//
//  HumidityWindLabel.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import UIKit

class HumidityWindLabel: UILabel {
    init(text: String, font: UIFont = .systemFont(ofSize: 12, weight: .semibold), textColor: UIColor = .whitePrimary) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
