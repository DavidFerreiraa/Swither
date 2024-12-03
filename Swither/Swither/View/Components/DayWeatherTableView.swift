//
//  DayWeatherTableView.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import UIKit

class DayWeatherTableView: UITableView {
    var data: [Daily] = []
    
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayWeatherTableViewCell.identifier, for: indexPath) as? DayWeatherTableViewCell else {
            return UITableViewCell()
        }
        let actualDaily = data[indexPath.row]
        let icon: String = actualDaily.weather.first?.icon ?? "03n"
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        
        cell.loadData(iconUrl: imageUrl, min: String(actualDaily.temp.min.tempToString()), max: String(actualDaily.temp.max.tempToString()), weekDay: actualDaily.dt.toWeekDayName())
        return cell
    }
}
