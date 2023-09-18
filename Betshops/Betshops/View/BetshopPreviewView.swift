//
//  BetshopPreviewView.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation
import SwiftUI

struct BetshopPreviewView: View {
    @ObservedObject var viewModel: MapViewModel
    var betshop: BetshopModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("green_bubble")
                        .resizable()
                        .frame(width: 20, height: 30)
                    Text((betshop.address ?? "No Address") + ", " + (betshop.name ?? "Unknown"))
                        .font(.custom("Avenir-Medium", size: 20))
                        .foregroundColor(.black)
                        .lineLimit(3)
                    
                    Spacer()
                    
                    Button {
                        debugPrint("Close tapped!")
                        viewModel.showBetshopPreview = false
                    } label: {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                
                HStack {
                    Image("phone")
                        .resizable()
                        .frame(width: 20, height: 30)
                    Text((betshop.city ?? "Unknown") + ", " + (betshop.county ?? ""))
                        .font(.custom("Avenir-Medium", size: 20))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                
                HStack {
                    Button {
                        debugPrint("Open Now tapped!")
                    } label: {
                        Text("Open now")
                            .font(.custom("Avenir-Medium", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding(.trailing, 20)
                    
                    Button {
                        debugPrint("Route tapped!")
                    } label: {
                        Text("Route")
                            .font(.custom("Avenir-Medium", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
            }
            .padding([.horizontal, .vertical], 20)
        }
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal, 15)
    }
}
