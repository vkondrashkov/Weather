//
//  ViewController.swift
//  Weather
//
//  Created by Vladislav Kondrashkov on 10/21/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var timedForecastView: UICollectionView!
    @IBOutlet weak var weekForecastView: UICollectionView!
    
    var weekForecastPresenter: WeekForecastPresenter?
    var timedForecastPresenter: TimedForecastPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        timedForecastPresenter = TimedForecastPresenterImplementation()
        weekForecastPresenter = WeekForecastPresenterImplementation()
        
        timedForecastView.delegate = self
        timedForecastView.dataSource = self
        
        weekForecastView.delegate = self
        weekForecastView.dataSource = self
        
        // Hardcode
        for index in 1...5 {
            let timedForecast = TimedForecast(at: String(index) + " AM", is: index)
            let weekForecast = WeekdayForecast(on: String(index) + "day", temperatureAtMidday: index, temperatureAtNight: index)
            
            timedForecastPresenter!.addItem(timedForecast)
            weekForecastPresenter!.addItem(weekForecast)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.timedForecastView {
            return timedForecastPresenter!.count
        }
        if collectionView == self.weekForecastView {
            return weekForecastPresenter!.count
        }
        // Default value
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.timedForecastView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timedForecastCell", for: indexPath) as! TimedForecastCellView
            
            let item = timedForecastPresenter!.getItem(at: indexPath.row)
            
            cell.updateTimeLabel(text: item.getTime())
            cell.updateTemperatureLabel(text: item.getTemperature())
            
            return cell
        }
        if collectionView == self.weekForecastView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekForecastCell", for: indexPath) as! WeekForecastCellView
            
            let item = weekForecastPresenter!.getItem(at: indexPath.row)
            
            cell.updateWeekDayNameLabel(text: item.getName())
            cell.updateTemperatureAtNightLabel(text: item.getTemperatureAtNight())
            cell.updateTemperatureAtMiddayLabel(text: item.getTemperatureAtMidday())
            
            return cell
        }
        // Default value
        let cell = UICollectionViewCell()
        return cell
    }
}

