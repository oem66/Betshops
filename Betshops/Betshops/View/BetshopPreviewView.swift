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
                    Image(AssetNames.shared.green_bubble)
                        .resizable()
                        .frame(width: 20, height: 30)
                    Text((betshop.address ?? "\(LocalizedStringKey("unknown"))") + ", " + (betshop.name ?? "\(LocalizedStringKey("unknown"))"))
                        .font(.custom(ApplicationConfiguration.shared.main_font, size: 20))
                        .foregroundColor(.black)
                        .lineLimit(3)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            viewModel.showBetshopPreview = false
                            viewModel.selectedBetshop = BetshopModel()
                        }
                    } label: {
                        Image(AssetNames.shared.close)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                
                HStack {
                    Image(systemName: AssetNames.shared.house_fill)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(ApplicationConfiguration.shared.app_green_color)
                    Text((betshop.city ?? "\(LocalizedStringKey("unknown"))") + ", " + (betshop.county ?? "\(LocalizedStringKey("unknown"))"))
                        .font(.custom(ApplicationConfiguration.shared.main_font, size: 20))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                
                HStack(spacing: 10) {
                    Button {
                        debugPrint("Open Now tapped!")
                    } label: {
                        Text(viewModel.checkOpenHours() ? LocalizedStringKey("open_now") : LocalizedStringKey("closed_now"))
                            .font(.custom(ApplicationConfiguration.shared.main_font, size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.checkOpenHours() ? Color(red: 140/255, green: 187/255, blue: 21/255) : .red)
                    }
                    .padding(.trailing, 20)
                    
                    Divider().frame(width: 3, height: 45)
                    
                    Button {
                        viewModel.navigateToCoordinates(latitude: betshop.location?.lat ?? 48.137154, longitude: betshop.location?.lng ?? 11.576124)
                    } label: {
                        Text(LocalizedStringKey("route"))
                            .font(.custom(ApplicationConfiguration.shared.main_font, size: 20))
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
