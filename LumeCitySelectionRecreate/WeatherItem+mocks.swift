import Foundation

extension WeatherItem {
  static var mocks: [WeatherItem] {
    [
      WeatherItem(
        id: UUID(),
        cityName: "New York",
        date: Date(),
        symbolName: "sun.max.fill",
        description: "Sunny",
        temperature: Measurement(value: 25, unit: .celsius),
        apparentTemperature: Measurement(value: 26, unit: .celsius),
        windSpeed: Measurement(value: 10, unit: .kilometersPerHour),
        humidity: 0.65
      ),
      WeatherItem(
        id: UUID(),
        cityName: "Tokyo",
        date: Date(),
        symbolName: "cloud.rain.fill",
        description: "Rainy",
        temperature: Measurement(value: 18, unit: .celsius),
        apparentTemperature: Measurement(value: 17, unit: .celsius),
        windSpeed: Measurement(value: 15, unit: .kilometersPerHour),
        humidity: 0.85
      ),
      WeatherItem(
        id: UUID(),
        cityName: "Paris",
        date: Date(),
        symbolName: "cloud.fill",
        description: "Cloudy",
        temperature: Measurement(value: 20, unit: .celsius),
        apparentTemperature: Measurement(value: 19, unit: .celsius),
        windSpeed: Measurement(value: 12, unit: .kilometersPerHour),
        humidity: 0.75
      ),
      WeatherItem(
        id: UUID(),
        cityName: "Bangkok",
        date: Date(),
        symbolName: "cloud.sun.fill",
        description: "Partly Cloudy",
        temperature: Measurement(value: 32, unit: .celsius),
        apparentTemperature: Measurement(value: 35, unit: .celsius),
        windSpeed: Measurement(value: 8, unit: .kilometersPerHour),
        humidity: 0.70
      )
    ]
  }
}

extension WeatherItem {
  static var bangkok: [WeatherItem] {
    [32.0, 33.0, 34.0, 33.0, 34.0, 35.0, 34.0, 33.0, 32.0, 31.0, 30.0, 29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 34.0, 33.0, 32.0, 31.0, 29.0, 31.0]
      .map { Measurement(value: $0, unit: .celsius) }
      .map {
        WeatherItem(
          id: UUID(),
          cityName: "Bangkok",
          date: Date(),
          symbolName: "cloud.sun.fill",
          description: "Partly Cloudy",
          temperature: $0,
          apparentTemperature: $0,
          windSpeed: Measurement(value: 8, unit: .kilometersPerHour),
          humidity: 0.70
        )
      }
  }
}
