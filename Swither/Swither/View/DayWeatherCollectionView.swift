//
//  CollectionDayWeather.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//
import UIKit

class DayWeatherCollectionView: UICollectionView {
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayWeatherCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}
