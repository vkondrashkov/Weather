//
//  WeatherViewController.swift
//  Weather
//
//  Created by Vladislav Kondrashkov on 10/22/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: WeatherPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherView = WeatherViewImplementation()
        weatherView.timedForecastView.delegate = self
        weatherView.weekForecastView.delegate = self
        self.view = weatherView
        
        presenter = WeatherPresenterImplementation(view: weatherView)
        presenter.viewDidLoad()
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let view = view as? WeatherViewImplementation else { return CGSize.zero }
        if collectionView == view.timedForecastView {
            return CGSize(width: 60, height: 90)
        }
        if collectionView == view.weekForecastView {
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
        return CGSize.zero
    }
}
