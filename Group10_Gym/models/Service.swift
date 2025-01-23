//
//  Service.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-16.
//

import Foundation

// Define the Service class that conforms to the IsPurchasable protocol
class Service: IsPurchasable {
    
    // Properties of the Service class
    let id: String
    let trainingType: String
    let totalSessions: Int
    let price: Double
    
    // Initializer for the Service class
    init(id: String, trainingType: String, totalSessions: Int, price: Double) throws {
        // Validation for the provided parameters using guard statements
        guard !id.isEmpty else {
            throw ServiceError.invalidId
        }
        guard !trainingType.isEmpty else {
            throw ServiceError.invalidTrainningType
        }
        guard totalSessions > 0 else {
            throw ServiceError.invalidSessions
        }
        guard price > 0 else {
            throw ServiceError.invalidPrice  
        }
        
        // Assign values to properties after validation
        self.id = id
        self.trainingType = trainingType
        self.totalSessions = totalSessions
        self.price = price
    }
    
    // Computed property that returns the detailed service information
    var serviceInfo: [String: Any] {
        // Returns a formatted string that provides detailed information about the service
        return ["Service ID": id, "Workout Type": trainingType, "Total Sessions": totalSessions, "Price": price]
    }
}
