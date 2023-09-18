//
//  BetshopPinView.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation
import SwiftUI

struct BetshopPinView: View {
    @ObservedObject var viewModel: MapViewModel
    var betshop: BetshopModel
    @State private var betshop_tapped = false
    
    var body: some View {
        ZStack {
            if betshop_tapped {
                Image("green_pin")
                    .resizable()
                    .frame(width: 40, height: 50)
                    .foregroundColor(.black)
            } else {
                Image("blue_pin")
                    .resizable()
                    .frame(width: 30, height: 40)
                    .foregroundColor(.black)
            }
            
        }
        .onTapGesture {
            betshop_tapped.toggle()
            viewModel.setSelectedBetshop(betshop)
        }
    }
}
