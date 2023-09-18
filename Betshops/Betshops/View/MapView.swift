//
//  MapView.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.betshops) { betshop in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: betshop.location.lat, longitude: betshop.location.lng)) {
                    ZStack {
                        Image(systemName: "mappin")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.black)
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
        .onAppear {
            viewModel.setupLocationServices()
            viewModel.getBetshops()
        }
    }
}
