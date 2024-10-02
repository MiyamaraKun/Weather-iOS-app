#Preview {
    ContentView()
}



import SwiftUI

struct ContentView: View {
    //@State private var isNight = false
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var hourModel = HourlyWeather()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var windManager = WindManager()
    //@ObservedObject var compassManager = CompassManager()
    
    var body: some View {
        let currentHour = getCurrentHour()
        
        ZStack {
            
                BackgroundView(isDay: Int32(viewModel.weatherData?.current.isDay ?? 1))
                //VideoBackgroundView()
                    .ignoresSafeArea()
                
            
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack{
                    
                    
                    
                    if let location = locationManager.location {
                        VStack {
                            if let cityName = locationManager.cityName {
                                //Text("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude) - \(cityName)")
                            
                        
                   
                        CityTextView(cityName: "\(cityName)")
                            .padding(.top, 100)
                            } else {
                                //Text("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                                CityTextView(cityName: "__ __")
                                    .padding(.top, 100)
                            }
                        }
                    } else {
                        //Text("Fetching location...")
                    }
                   
                    
                    
                    
                    if let weatherData = viewModel.weatherData {
                        
                        MainWeatherStatus( temp: Int(weatherData.current.temperature2m), logo: weatherSymbol(for: weatherData.current.weatherCode, index: currentHour), stat: weatherDescription(for: weatherData.current.weatherCode), h: Int(weatherData.daily.temperature2mMax.first ?? 0), l:Int(weatherData.daily.temperature2mMin.first ?? 0))
                            .padding(.bottom, 10)
                    } else {
                        Text("__ __") // Placeholder while data is being fetched
                            .font(.system(size:45,weight: .semibold,design: .default))
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    VStack{
                        HStack{
                            Image(systemName: "clock")
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            Text("HOURLY FORECAST")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .padding(.leading, 0)
                                .foregroundColor(.white)
                        }
                        Divider()
                            .frame(height: 1)
                            .background(Color.white.opacity(0.4))
                            .padding(.horizontal)
                        
                        
                        ScrollViewReader() { scrollViewProxy in
                            ScrollView(.horizontal, showsIndicators: false){
                                
                                
                                
                                
                                HStack(spacing: 20){
                                    
                                    
                                   
                        
                                    
                                    
                                    if let weatherData = viewModel.weatherData {
                                        
                                        
                                        VStack{
                                            Text("Now")
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(.white)
                                            
                                            
                                            Image(systemName : weatherSymbol(for: weatherData.current.weatherCode, index: currentHour))
                                                .symbolRenderingMode(.multicolor)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 40, height: 40)
                                            Text("\(Int(weatherData.current.temperature2m))°")
                                                .font(.system(size: 28, weight: .semibold))
                                                .foregroundColor(.white)
                                        }
                                    
                                
                            
                                        
                                        
                                        if let hourly = hourModel.currentTemperature{
                                            ForEach((currentHour+1)...23, id: \.self) { index in
                                                HourWeather(index: index, weatherLogo: weatherSymbol(for: hourly.hourly.weatherCode[index], index: index), temp: Int(hourly.hourly.temperature2m[index]))
                                            }
                                            ForEach(0...23, id: \.self) { index in
                                                HourWeather(index: index, weatherLogo: weatherSymbol(for: hourly.hourly.weatherCode[index+24], index: index+24), temp: Int(hourly.hourly.temperature2m[index+24]))
                                                
                                                
                                            }
                                        }else{} }
                                else{
                                 
                                }
                                }
                                .padding(.leading)
                            }
                        }
                        
                        
                    }   .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height*0.21)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                    
                    
                    Spacer()
                    VStack{
                        HStack{
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            Text("WEEKLY FORECAST")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .padding(.leading, 0)
                                .foregroundColor(.white)
                        }
                        Divider()
                            .frame(height: 1)
                            .background(Color.white.opacity(0.4))
                            .padding(.horizontal)
                       
                        VStack{
                            HStack{
                                Text("Today")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                                    
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height*0.21)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                    
                    Spacer()
                    HStack{
                        
                        VStack {
                            HStack {
                                Image(systemName: "thermometer.medium")
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                
                                Text("FEELS LIKE")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding([.leading, .trailing], 0)
                                
                                Spacer()
                            }
                            .padding(.top, 10)
                            Spacer()
                            let feelLike = Int(viewModel.weatherData?.current.apparentTemperature ?? 0)
                            Text("\(feelLike)°")
                                .font(.system(size:45,weight: .light,design: .default))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.44, height: UIScreen.main.bounds.height*0.21)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        
                        
                        
                        
                        VStack {
                            HStack {
                                Image(systemName: "moon.fill")
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                
                                Text("MOON")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding([.leading, .trailing], 0)
                                
                                Spacer()
                            }
                            .padding(.top, 10)
                            Spacer()
                            
                            
                            
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.44, height: UIScreen.main.bounds.height*0.21)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        
                        
                    }
                    VStack {
                                                HStack(alignment: .top) {
                                                    Image(systemName: "wind")
                                                        .foregroundColor(.white)
                                                        .padding(.leading, 10)
                                                        .padding(.top, 10)
                                                    
                                                    Text("WIND")
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                        .padding([.leading, .trailing], 0)
                                                        .padding(.top, 10)
                                                    
                                                    Spacer()
                                                }
                                                Divider()
                                                    .frame(height: 1)
                                                    .background(Color.white.opacity(0.4))
                                                    .padding(.horizontal)
                                                Spacer()
                                                HStack(spacing:10){
                                                    VStack{
                                                        if let windData = windManager.windData {
                                                            VStack(alignment: .leading) {
                                                                HStack(spacing:20){
                                                                    Text("\(windData.current.windSpeed10m, specifier: "%.2f")")
                                                                        .foregroundColor(.white)
                                                                        .padding(.top, 10)
                                                                        .font(.system(size: 30).bold())
                                                                    VStack{
                                                                        Text("KM/H")
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 12))
                                                                        Text("Speed")
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 12).bold())
                                                                    }
                                                                }
                                                                HStack(spacing:10){
                                                                    Text("\(windData.current.windGusts10m, specifier: "%.2f")")
                                                                        .foregroundColor(.white)
                                                                        .font(.system(size: 30).bold())
                                                                    
                                                                    VStack{
                                                                        Text("KM/H")
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 12).bold())
                                                                        Text("Gust")
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 12).bold())
                                                                    }
                                                                    
                                                                }
                                                            }
                                                          
                                                        } else {
                                                            Text("Fetching wind data...")
                                                                .foregroundColor(.white)
                                                        }
                                                        Spacer()
                                                        
                                                    }
                                                    
                                                    .padding(20)
                                                    
                                                    VStack(spacing:10){
                                                        if let windData = windManager.windData {
                                                            Image(systemName: "location.north")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 70, height: 70)
                                                                .foregroundColor(.white)
                                                                .opacity(0.4)
                                                            // Rotate the arrow based on the wind direction
                                                                .rotationEffect(.degrees(-Double(windData.current.windDirection10m)))  // Negative for correct rotation
                                                                .animation(.easeInOut, value: windData.current.windDirection10m)
                                                            Text(" \(windData.current.windDirection10m, specifier: "%.0f")°")
                                                                .foregroundColor(.white)
                                                                .font(.system(size: 15))
                                                            Spacer()
                                                                
                                                        }
                                                    }
                                                }
                                               
                                            }
                                            .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.23)
                                            .background(Color.white.opacity(0.2))
                                            .cornerRadius(12)
                    
                    Spacer()
                }
            }
            }
            .padding()
            .onAppear {
                Task {
                                await viewModel.fetchWeatherData(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
                    await hourModel.fetchCurrentWeather(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
                    await windManager.fetchWindData(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
                               // await loco.locationManager()
                            }
                
            }
          }
                                                
                                                
                                             
    
    func formatSunriseTimes(floatValues: [Float]) -> [String] {
        var formattedTimes = [String]()
        
        for floatValue in floatValues {
            // Convert float to string
            let stringValue = String(format: "%.2f", floatValue)
            
            // Extracting hours and minutes
            let components = stringValue.components(separatedBy: ".")
            guard components.count == 2, let hours = Int(components[0]), let minutes = Int(components[1]) else {
                continue // Skip invalid format
            }
            
            // Formatted time string
            let formattedTime = String(format: "%02d:%02d", hours, minutes)
            
            formattedTimes.append(formattedTime)
        }
        
        return formattedTimes
    }
    
    
    
    
    
    
    
    
    
    
    
    func getCurrentHour() -> Int {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        return hour
    }
    
    func weatherSymbol(for code: Float, index: Int) -> String {
        if((5 < index && index < 21) || (29 < index && index < 45)){
            switch code {
            case 0:
                return "sun.max.fill"
            case 1, 2:
                return "cloud.sun.fill"
            case 3:
                return "cloud.fill"
            case 45, 48:
                return "cloud.fog.fill"
            case 51, 53, 55:
                return "cloud.drizzle.fill"
            case 56, 57:
                return "cloud.sleet.fill"
            case 61, 63:
                return "cloud.rain.fill"
            case 65:
                return "cloud.rain.heavy.fill"
            case 66, 67:
                return "cloud.sleet.fill"
            case 71, 73, 75:
                return "cloud.snow.fill"
            case 77:
                return "cloud.snow.fill"
            case 80, 81, 82:
                return "cloud.heavyrain.fill"
            case 85, 86:
                return "cloud.snow.fill"
            case 95:
                return "cloud.bolt.fill"
            case 96, 99:
                return "cloud.bolt.rain.fill"
            default:
                return "questionmark.circle.fill"
            }}
        else{
            switch code {
            case 0:
                return "moon.fill"
            case 1, 2:
                return "cloud.moon.fill"
            case 3:
                return "cloud.fill"
            case 45, 48:
                return "cloud.fog.fill"
            case 51, 53, 55:
                return "cloud.drizzle.fill"
            case 56, 57:
                return "cloud.sleet.fill"
            case 61, 63:
                return "cloud.rain.fill"
            case 65:
                return "cloud.rain.heavy.fill"
            case 66, 67:
                return "cloud.sleet.fill"
            case 71, 73, 75:
                return "cloud.snow.fill"
            case 77:
                return "cloud.snow.fill"
            case 80, 81, 82:
                return "cloud.heavyrain.fill"
            case 85, 86:
                return "cloud.snow.fill"
            case 95:
                return "cloud.bolt.fill"
            case 96, 99:
                return "cloud.bolt.rain.fill"
            default:
                return "questionmark.circle.fill"
            }
        }
    }
    
    
    
    
    func weatherDescription(for code: Float) -> String {
        switch code {
        case 0:
            return "Clear sky"
        case 1:
            return "Mainly clear"
        case 2:
            return "Partly cloudy"
        case 3:
            return "Overcast"
        case 45:
            return "Fog"
        case 48:
            return "Depositing rime fog"
        case 51:
            return "Light Drizzle"
        case 53:
            return "Moderate Drizzle"
        case 55:
            return "Dense Drizzle"
        case 56:
            return "Light Freezing Drizzle"
        case 57:
            return "Dense Freezing Drizzle"
        case 61:
            return "Slight Rain"
        case 63:
            return "Moderate Rain"
        case 65:
            return "Heavy Rain"
        case 66:
            return "Light Freezing Rain"
        case 67:
            return "Heavy Freezing Rain"
        case 71:
            return "Slight Snow fall"
        case 73:
            return "Moderate Snow fall"
        case 75:
            return "Heavy Snow fall"
        case 77:
            return "Snow grains"
        case 80:
            return "Slight Rain showers"
        case 81:
            return "Moderate Rain showers"
        case 82:
            return "Violent Rain showers"
        case 85:
            return "Slight Snow showers"
        case 86:
            return "Heavy Snow showers"
        case 95:
            return "Slight Thunderstorm"
        case 96:
            return "Thunderstorm with slight hail"
        case 99:
            return "Thunderstorm with heavy hail"
        default:
            return  "__ __"
        }
    }
    
      //  .padding()
    }


  

//                                Button {
//                                    print(viewModel.weatherData)
//                                    //isNight.toggle()
//                                } label: {
//                                    WeatherButton(title: "Change Day Time", textColor: Color.indigo, backgroundColor: .white)
//                                }

//
//
//                                if let weatherData = viewModel.weatherData {
//                                 var feelLike = Int(weatherData.current.apparentTemperature)
//
//                                Text("\(feelLike)°")
//                                    .font(.system(size:45,weight: .light,design: .default))
//                                    .colorMultiply(Color.white.opacity(0.5))
//                                } else {
//                                }
//
//

