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
    
    // Method to search and format services by keyword in the gym
    func searchService(keyword: String) {
        // Filter services based on the keyword
        let results = services.values.filter {
            // Case-insensitive search on trainingType
            $0.trainingType.lowercased().contains(keyword.lowercased())
        }
        
        if results.isEmpty {
            print("No services found matching the keyword: \(keyword)")
        } else {
            
            for service in results {
                print(service.serviceInfo)
            }
        }
    }

    func listAllServices() {
        print("\nAll Services:\n")
        for service in services.values {
            print(service.serviceInfo)
        }
    }
    
    // Method to get a service by its ID
    func getService(byId id: String) -> Service? {
        return services[id]
    }
}
