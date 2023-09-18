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
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.137154, longitude: 11.576124), latitudinalMeters: 200, longitudinalMeters: 200)
    @Published var betshops = [BetshopModel]()
    
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
                debugPrint("Betshops: \(success)")
                populateBetshops(success)
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
    
    private func populateBetshops(_ data: BetshopResponseModel) {
        DispatchQueue.main.async {
            self.betshops = data.betshops
        }
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
