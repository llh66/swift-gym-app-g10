//
//  PersonalTraining.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-21.
//

import Foundation

// PersonalTraining class inherits from the Service class, representing a personal training session
class PersonalTraining: Service {
    
    // Properties specific to PersonalTraining
    let trainerName: String
    let sessionTime: String
    
    // Initializer for PersonalTraining
    init(id: String, trainingType: String, totalSessions: Int, price: Double, trainerName: String, sessionTime: String) throws {
        
        // Validate the trainer's name and session time
        guard !trainerName.isEmpty else {
            throw ServiceError.invalidTrainerName
        }
        
        guard !sessionTime.isEmpty else {
            throw ServiceError.invalidSessionTime
        }
        
        // Assign the validated values to the class properties
        self.trainerName = trainerName
        self.sessionTime = sessionTime
        
        // Call the initializer of the superclass (Service) to initialize the shared properties
        try super.init(id: id, trainingType: trainingType, totalSessions: totalSessions, price: price)
    }
    
    // Computed property to get information about the personal training service
    override var serviceInfo: [String: Any] {
        var serviceInfo = super.serviceInfo
        serviceInfo["Trainer"] = trainerName
        serviceInfo["Session Time"] = sessionTime
        return serviceInfo
    }
}
