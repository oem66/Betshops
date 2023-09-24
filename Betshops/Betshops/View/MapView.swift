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
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some View {
        GeometryReader { proxy in
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.betshops) { betshop in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: betshop.location?.lat ?? 48.137154, longitude: betshop.location?.lng ?? 11.576124)) {
                    BetshopPinView(viewModel: viewModel, betshop: betshop)
                }
            }
            .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                if viewModel.showBetshopPreview {
                    BetshopPreviewView(viewModel: viewModel, betshop: viewModel.selectedBetshop)
                }
            }
        }
        .onAppear {
            viewModel.setupLocationServices()
            if networkMonitor.isConnected {
                viewModel.getBetshops()
            } else {
                viewModel.showNetworkAlert.toggle()
            }
        }
        .onDisappear {
            networkMonitor.stop()
        }
        .onChange(of: networkMonitor.isConnected) { newIsConnected in
            if newIsConnected {
                viewModel.getBetshops()
            }
        }
        .alert(isPresented: $viewModel.showNetworkAlert) {
            Alert(
                title: Text(LocalizedStringKey("no_internet")),
                message: Text(LocalizedStringKey("no_internet_description")),
                primaryButton: .default(Text(LocalizedStringKey("open_settings")), action: {
                    viewModel.openSettings()
                }),
                secondaryButton: .cancel()
            )
        }
    }
}
