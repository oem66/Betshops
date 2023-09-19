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
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 140/255, green: 187/255, blue: 21/255))
                    Text((betshop.city ?? "Unknown") + ", " + (betshop.county ?? ""))
                        .font(.custom("Avenir-Medium", size: 20))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                
                HStack(spacing: 10) {
                    Button {
                        debugPrint("Open Now tapped!")
                    } label: {
                        Text("Open now")
                            .font(.custom("Avenir-Medium", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 140/255, green: 187/255, blue: 21/255))
                    }
                    .padding(.trailing, 20)
                    
                    Divider().frame(width: 3, height: 45)
                    
                    Button {
                        debugPrint("Route tapped!")
                    } label: {
                        Text("Route")
                            .font(.custom("Avenir-Medium", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 21/255, green: 46/255, blue: 128/255))
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
