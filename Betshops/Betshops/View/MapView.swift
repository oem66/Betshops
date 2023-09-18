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
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .none)
                .ignoresSafeArea(.all)
        }
        .onAppear {
            viewModel.setupLocationServices()
            viewModel.getBetshops()
        }
    }
}
