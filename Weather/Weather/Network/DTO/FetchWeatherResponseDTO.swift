//
//  FetchWeatherResponseDTO.swift
//  Weather
//
//  Created by 조성민 on 2/3/25.
//

struct FetchWeatherResponseDTO: Decodable {
    let main: WeatherMain
    let wind: WeatherWind
}

struct WeatherMain: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct WeatherWind: Decodable {
    let speed: Double
}
