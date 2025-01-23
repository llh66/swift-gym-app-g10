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
    func searchService(keyword: String) -> String {
        // Filter services based on the keyword
        let results = services.values.filter {
            // Case-insensitive search on trainingType
            $0.trainingType.lowercased().contains(keyword.lowercased())
        }
        
        if results.isEmpty {
            return "No services found matching the keyword: \(keyword)"
        } else {
            var resultString = "Search results for keyword: '\(keyword)':\n"
            
            for service in results {
                resultString += "\nService ID: \(service.id)\n"
                resultString += "Workout Type: \(service.trainingType)\n"
                resultString += "Total Sessions: \(service.totalSessions)\n"
                resultString += "Price: $\(String(format: "%.2f", service.price))\n"
                // Now, print any additional service-specific information
                for (key, value) in service.serviceInfo {
                    // Skip already printed properties
                    if key == "Service ID" || key == "Workout Type" || key == "Total Sessions" || key == "Price" {
                        continue
                    }
                    resultString += "\(key): \(value)\n"
                }
            }
            
            return resultString
        }
    }

    func listAllServices() {
        print("All Services:")
        for service in services.values {
            print("Service ID: \(service.id)")
            print("Workout Type: \(service.trainingType)")
            print("Total Sessions: \(service.totalSessions)")
            print("Price: $\(String(format: "%.2f", service.price))\n")
            for (key, value) in service.serviceInfo {
                // Skip already printed properties
                if key == "Service ID" || key == "Workout Type" || key == "Total Sessions" || key == "Price" {
                    continue
                }
                print("\(key): \(value)")
            }
        }
    }

    
    // Method to get a service by its ID 
    func getService(byId id: String) -> Service? {
        return services[id]
    }
}
