//
//  CityTextView.swift
//  sample
//
//  Created by Adityapal Waraich on 2024-05-01.
//

import Foundation
import SwiftUI

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        
        Text(cityName)
            .font(.system(size:20,weight: .bold,design: .default))
            .foregroundColor(.white)
            
    }
}
