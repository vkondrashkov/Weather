//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Vladislav Kondrashkov on 10/22/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

protocol WeatherPresenter {
    func viewDidLoad()
}

class WeatherPresenterImplementation: WeatherPresenter {
    let view: WeatherView!
    
    init(view: WeatherView) {
        self.view = view
    }
    
    func viewDidLoad() {
        let service = OpenWeatherService()
        service.fetchCurrentForecast(city: "Minsk") { currentForecast in
            if let currentForecast = currentForecast {
                self.view.display(currentCity: currentForecast.city)
                self.view.display(forecastStatus: currentForecast.status)
                self.view.display(currentTemperature: currentForecast.temperature)
            }
        }
        service.fetchTimedForecast(city: "Minsk") { timedForecastList in
            self.view.display(timedForecast: timedForecastList)
        }
        service.fetchWeekForecast(city: "Minsk") { weekForecastList in
            self.view.display(weekForecast: weekForecastList)
        }
    }
}
