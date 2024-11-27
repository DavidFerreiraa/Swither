//
//  DayWeatherTableView.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import UIKit

class DayWeatherTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.dataSource = self
        self.register(DayWeatherTableViewCell.self, forCellReuseIdentifier: DayWeatherTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayWeatherTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayWeatherTableViewCell.identifier, for: indexPath)
        return cell
    }
}
