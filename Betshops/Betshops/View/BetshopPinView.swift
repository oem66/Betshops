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
    @State private var betshop_tapped = false
    var betshop: BetshopModel
    
    var body: some View {
        ZStack {
            if viewModel.showBetshopPreview {
                if betshop.id == viewModel.selectedBetshop.id {
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
                } else {
                    Image("blue_pin")
                        .resizable()
                        .frame(width: 30, height: 40)
                        .foregroundColor(.black)
                }
            } else {
                Image("blue_pin")
                    .resizable()
                    .frame(width: 30, height: 40)
                    .foregroundColor(.black)
            }
        }
        .onTapGesture {
            withAnimation {
                betshop_tapped.toggle()
                viewModel.showBetshopPreview = true
            }
            viewModel.setSelectedBetshop(betshop)
        }
    }
}
