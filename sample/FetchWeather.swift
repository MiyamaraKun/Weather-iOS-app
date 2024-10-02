import Foundation
import OpenMeteoSdk
//import Combine

struct WeatherData {
    let current: Current
    let daily: Daily

    struct Current {
        let time: Date
        let temperature2m: Float
        let relativeHumidity2m: Float
        let apparentTemperature: Float
        let isDay: Float
        let weatherCode: Float
            }
    
    struct Daily {
            let time: [Date]
            let temperature2mMax: [Float]
            let temperature2mMin: [Float]
            let sunrise: [Float]
            let sunset: [Float]
        }
        }
    




class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    private let locationManager = LocationManager()
    
    func fetchWeatherData(latitude: Double, longitude: Double) async {
        
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=auto&forecast_days=1&format=flatbuffers")!
        
        
        
        do {
            
            let responses = try await WeatherApiResponse.fetch(url: url)
            let response = responses[0]

            let utcOffsetSeconds = response.utcOffsetSeconds
//            let timezone = response.timezone
//            let timezoneAbbreviation = response.timezoneAbbreviation
//            let latitude = response.latitude
//            let longitude = response.longitude
            
            let current = response.current!
            let daily = response.daily!
            
            let data = WeatherData(
                current: .init(
                        time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                        temperature2m: current.variables(at: 0)!.value.rounded(),
                        relativeHumidity2m: current.variables(at: 1)!.value,
                        apparentTemperature: current.variables(at: 2)!.value,
                        isDay: current.variables(at: 3)!.value,
                        weatherCode: current.variables(at: 4)!.value
                    ),
                
                daily: .init(
                        time: daily.getDateTime(offset: utcOffsetSeconds),
                        temperature2mMax: daily.variables(at: 0)!.values,
                        temperature2mMin: daily.variables(at: 1)!.values,
                        sunrise: daily.variables(at: 2)!.values,
                        sunset: daily.variables(at: 3)!.values
                
                    )
                )
            
        
            DispatchQueue.main.async {
                self.weatherData = data
            }
            
            
        } catch {
            // Handle errorss
            print("Error fetching weather data: \(error)")
        }
    }
}


