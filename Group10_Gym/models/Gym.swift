//
//  Gym.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-16.
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
    
    func listAllServices() {
        print("All Services:")
        for service in services.values {
            print("Service ID: \(service.id)")
            print("Workout Type: \(service.trainingType)")
            print("Total Sessions: \(service.totalSessions)")
            print("Price: $\(service.price)")
            for (key, value) in service.serviceInfo {
                // Skip already printed properties
                if key == "Service ID" || key == "Workout Type" || key == "Total Sessions" || key == "Price" {
                    continue
                }
                print("\(key): \(value)")
            }
            print()  // To add a blank line after each service value
        }
    }

    
    // Method to get a service by its ID (polymorphic behavior)
    func getService(byId id: String) -> Service? {
        return services[id]
    }
}
