//
//  Appointment.swift
//  VaxGuideSG
//
//  Created by bryan on 28/7/21.
//

import Foundation

// MARK: - Appointment
struct Appointment: Codable {
    let nric, location, date, time: String
    let dosage: Int
}
