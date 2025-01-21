//
//  Gym.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-21.
//
import Foundation

class Gym {
    
    // Array to store all services added to the gym (such as Fitness Classes, Personal Trainings, etc.)
    var services: [Service] = []
    
    // Throws an error if adding the service fails
    func addService(_ service: Service) throws {
        services.append(service)  // Adds the provided service to the `services` array
    }
    
    // Method to search for services by training type
    func searchService(keyword: String) -> [Service] {
        return services.filter {
            // Lowercase both the `trainingType` and keyword for case-insensitive comparison
            $0.trainingType.lowercased().contains(keyword.lowercased())
        }
    }
    
    // Method to list all services currently in the gym
    func listAllServices() {
        print("All Services:")
        for service in services {
            // Print detailed service info for each service in the array
            print(service.serviceInfo)
        }
    }
}
