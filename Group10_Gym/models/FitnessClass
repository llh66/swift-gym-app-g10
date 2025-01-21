//
//  FitnessClass.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-21.
//

import Foundation

//subclass of Service that represents a specific type of service 
class FitnessClass: Service {
    // Properties specific to the fitness class
    let duration: Int
    let trainerName: String
    
    // The initializer is used to set up the properties of the FitnessClass object.
    init(id: String, trainingType: String, totalSessions: Int, price: Double, duration: Int, trainerName: String) throws {
        
        // Ensure the duration is greater than 0 
        guard duration > 0 else {
            throw ServiceError.invalidDuration
        }
        
        // Ensure the trainer's name is not empty
        guard !trainerName.isEmpty else {
            throw ServiceError.invalidTrainerName
        }
        
        // Set the values for the duration and trainerName properties
        self.duration = duration
        self.trainerName = trainerName
        
        // Call the superclass's initializer to initialize the shared properties
        try super.init(id: id, trainingType: trainingType, totalSessions: totalSessions, price: price)
    }
    
    // Computed property to return information about the service, overriding the serviceInfo from the parent class
    override var serviceInfo: String {
        // Return the superclass's service information, appending specific details for FitnessClass
        return super.serviceInfo + "\nDuration: \(duration) minutes \nTrainer: \(trainerName)"
    }
}
