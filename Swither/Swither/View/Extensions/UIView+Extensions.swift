//
//  UIView+Extensions.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import Foundation
import UIKit

extension UIView {
    func setConstraintsToParent(_ parent: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
        ])
    }
    
    func skeleton(cornerRadius: Float = 20) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isSkeletonable = true
        self.skeletonCornerRadius = cornerRadius
        self.layer.zPosition = 10
        return self
    }
}
