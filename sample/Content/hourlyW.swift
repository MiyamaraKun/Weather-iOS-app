//
//  hourlyW.swift
//  sample
//
//  Created by Adityapal Waraich on 2024-05-03.
//

import Foundation
import SwiftUI

struct HourWeather: View {
    
    //var hourOfDay: String
    var index: Int
    var weatherLogo: String
    var temp: Int
    
    var body: some View {
        VStack{
            if(index > 12 ){
                Text("\(index - 12)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                +
                Text("PM")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
            } else if(index == 0){
                Text("12")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                +
                Text("AM")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
            }else{
                       
                Text("\(index)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                +
                Text("AM")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
            }
            
            Image(systemName : weatherLogo)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temp)°")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.white)
            
        }
        .padding(.leading, 10)
    }
}
