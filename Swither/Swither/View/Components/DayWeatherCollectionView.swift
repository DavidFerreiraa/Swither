//
//  CollectionDayWeather.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//
import UIKit

class DayWeatherCollectionView: UICollectionView {
    var data: [Current] = []
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 68, height: 84)
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 12,
                                           bottom: 0,
                                           right: 12)
        super.init(frame: .zero, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.backgroundColor = .clear
        self.register(DayWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DayWeatherCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayWeatherCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayWeatherCollectionViewCell.identifier, for: indexPath) as? DayWeatherCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        let actualHourly = data[indexPath.row]
        cell.loadData(time: actualHourly.dt.toHourFormat(), icon: UIImage(named: "sun-icon"), temperature: actualHourly.temp.tempToString())
        return cell
    }
}
