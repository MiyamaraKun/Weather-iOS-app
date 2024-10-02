//
//  MainWeatherStatus.swift
//  sample
//
//  Created by Adityapal Waraich on 2024-05-01.
//

import Foundation
import SwiftUI

struct MainWeatherStatus: View{
    //var imageName: String
    //var isDay: Int32
    var temp: Int
    var logo:String
    var stat: String
    var h:Int
    var l:Int
    var body: some View{
        VStack(spacing:6){
           // if(isDay == 1){
                Image(systemName: logo)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:180, height:180)
           // } else{
//                Image(systemName : logo)
//                    .renderingMode(.original)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width:180, height:180)
//            }
            
                    
                
                Text("\(temp)°")
                .font(.system(size: 80, weight:.light, design:.rounded))
                    .foregroundColor(.white)
            }
        .padding(.bottom, 10)
            Text(stat)
            .font(.system(size: 22, weight:.medium, design:.rounded))
            .padding(.bottom, 1)
            .foregroundColor(.white)
            Text("H:\(h)°  L:\(l)°")
            .font(.system(size: 20, weight:.light, design:.monospaced ))
            .foregroundColor(.white)
    }
}
