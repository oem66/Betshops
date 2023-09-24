//
//  ApplicationConfiguration.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 24. 9. 2023..
//

import Foundation
import SwiftUI

final class ApplicationConfiguration {
    static let shared = ApplicationConfiguration()
    private init() { }
    
    let main_font = "Avenir-Medium"
    let app_green_color: Color = Color(red: 140/255, green: 187/255, blue: 21/255)
}
