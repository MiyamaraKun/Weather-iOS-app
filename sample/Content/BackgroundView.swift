//
//  BackgroundView.swift
//  sample
//
//  Created by Adityapal Waraich on 2024-05-01.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    
    var isDay: Int32
    
    
    var body: some View {
        if(isDay == 1){
            //Image("Image")
            LinearGradient(gradient: Gradient(colors: [Color("dBottom"), Color("lBottom")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            //VideoBackgroundView2()
                .ignoresSafeArea()
            .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        } else{
             Image("back")
           // VideoBackgroundView1()
                .ignoresSafeArea()
             .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)        }
            
        }
    }
    

