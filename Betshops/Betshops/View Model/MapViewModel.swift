//
//  MapViewModel.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation
import CoreLocation
import MapKit
import Combine

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//latitude: 48.137154, longitude: 11.576124
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.137154, longitude: 11.576124), latitudinalMeters: 200, longitudinalMeters: 200)
    @Published var betshops = [BetshopModel]()
    @Published var selectedBetshop = BetshopModel()
    @Published var showBetshopPreview = false
    
    private let service: BetshopServiceProtocol
    var locationManager = CLLocationManager()
    
    init(service: BetshopServiceProtocol = BetshopService()) {
        self.service = service
    }
    
    // MARK: - Networking
    func getBetshops() {
        Task(priority: .background) {
            let model = BetshopRequestModel(boundingBox: "48.16124,11.60912,48.12229,11.52741")
            let result = await service.getBetshops(model: model)
            switch result {
            case .success(let success):
                populateBetshops(success)
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
    
    private func populateBetshops(_ data: BetshopResponseModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.betshops = data.betshops
        }
    }
    
    func setSelectedBetshop(_ betshop: BetshopModel) {
        DispatchQueue.main.async {
            self.selectedBetshop = betshop
        }
    }
    
    func checkOpenHours() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        
        if 8...16 ~= hour {
            return true
        } else {
            return false
        }
    }
    
    func navigateToCoordinates(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let destinationPlacemark = MKPlacemark(coordinate: coordinate)
        
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        destinationMapItem.name = "Destination"
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        destinationMapItem.openInMaps(launchOptions: launchOptions)
    }
    
    // MARK: - Location Services
    func setupLocationServices() {
        Task(priority: .background) {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.allowsBackgroundLocationUpdates = true
                self.locationManager.showsBackgroundLocationIndicator = true
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 50.0
            }
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            locationManager.requestAlwaysAuthorization()
        case .denied:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(center: location.coordinate, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
