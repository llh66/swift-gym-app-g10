//
//  Gym.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-21.
//
import Foundation

class Gym {
    // Dictionary to store services with the service ID as the key
    var services: [String: Service] = [:]
    
    // Method to add a service to the gym
    func addService(_ service: Service) throws {
        if services[service.id] != nil {
            throw ServiceError.invalidId // Prevent duplicate IDs
        }
        services[service.id] = service
    }
    
    // Method to search services by keyword
    func searchService(keyword: String) -> [Service] {
        return services.values.filter {
            // Case-insensitive search on trainingType
            $0.trainingType.lowercased().contains(keyword.lowercased())
        }
    }
    
    // Method to list all services in the gym
    func listAllServices() {
        print("All Services:")
        for service in services.values {
            print(service.serviceInfo)
        }
    }
    
    // Method to get a service by its ID 
    func getService(byId id: String) -> Service? {
        return services[id]
    }
}
