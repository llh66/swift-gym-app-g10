//
//  main.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-20.
//

import Foundation

//
//  main.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-20.
//

import Foundation

//initialize Gym
let gym = Gym()

// Adding initial services
do {
    try gym.addService(FitnessClass(id: "0077GY", trainingType: "Pilates", totalSessions: 10, price: 50.0, duration: 60, trainerName: "Kenny Smith"))
    try gym.addService(FitnessClass(id: "ABCXYZ", trainingType: "Stretching", totalSessions: 8, price: 40.0, duration: 45, trainerName: "Josh Allen"))
    try gym.addService(PersonalTraining(id: "PT2011", trainingType: "Weight Training", totalSessions: 5, price: 100.0, trainerName: "Michael B Jordan", sessionTime: "10:00 AM"))
} catch {
    print("Error adding initial services: \(error)")
}

// Main menu for gym owners
func gymOwnerMenu() {
    while true {
        print("\nGym Owner Menu:")
        print("1. Create new service")
        print("2. Search for service")
        print("3. List all services")
        print("4. Exit")
        print("Enter your choice: ", terminator: "")
        
        // Read input for the owner's menu choice
        guard let choice = readLine(), let option = Int(choice) else {
            print("Invalid input. Please try again.")
            continue
        }
        
        // Switch based on the owner's choice
        switch option {
        case 1:
            createNewService()
        case 2:
            searchForService()
        case 3:
            gym.listAllServices()
        case 4:
            return
        default:
            print("Invalid option. Please try again.")  // Handle invalid menu option
        }
    }
}

// Function for creating a new service (Fitness Class or Personal Training)
func createNewService() {
    // Input prompt for selecting service type (Fitness Class or Personal Training)
    var serviceType: Int?
    repeat {
        print("Enter service type (1 for Fitness Class, 2 for Personal Training): ", terminator: "")
        if let typeChoice = readLine(), let inputType = Int(typeChoice), (inputType == 1 || inputType == 2) {
            serviceType = inputType
        } else {
            print("Error: Invalid choice. Please enter 1 for Fitness Class or 2 for Personal Training.")
        }
    } while serviceType == nil

    // A flag to ensure we repeat the process if service creation is unsuccessful
    var isValidServiceCreated = false
    repeat {
        do {
            // Input for Service ID
            var id: String
            repeat {
                print("Enter service ID: ", terminator: "")
                id = readLine() ?? ""
                if id.isEmpty {
                    throw ServiceError.invalidId  // If ID is empty, throw error
                }
            } while id.isEmpty

            // Input for training type
            var trainingType: String
            repeat {
                print("Enter training type: ", terminator: "")
                trainingType = readLine() ?? ""
                if trainingType.isEmpty {
                    throw ServiceError.invalidTrainningType  // If training type is empty, throw error
                }
            } while trainingType.isEmpty

            // Input for total number of sessions
            var totalSessions: Int = 0
            repeat {
                print("Enter total number of sessions: ", terminator: "")
                if let inputSessions = Int(readLine() ?? ""), inputSessions > 0 {
                    totalSessions = inputSessions
                } else {
                    throw ServiceError.invalidSessions  // If sessions are invalid, throw error
                }
            } while totalSessions <= 0

            // Input for price
            var price: Double = 0.0
            repeat {
                print("Enter price: ", terminator: "")
                if let inputPrice = Double(readLine() ?? ""), inputPrice > 0 {
                    price = inputPrice
                } else {
                    throw ServiceError.invalidPrice  // If price is invalid, throw error
                }
            } while price <= 0

            // Service-specific input based on the selected service type
            if serviceType == 1 {
                // For FitnessClass service
                var duration: Int = 0
                repeat {
                    print("Enter duration (in minutes): ", terminator: "")
                    if let inputDuration = Int(readLine() ?? ""), inputDuration > 0 {
                        duration = inputDuration
                    } else {
                        throw ServiceError.invalidDuration  // If duration is invalid, throw error
                    }
                } while duration <= 0

                var trainerName: String
                repeat {
                    print("Enter trainer name: ", terminator: "")
                    trainerName = readLine() ?? ""
                    if trainerName.isEmpty {
                        throw ServiceError.invalidTrainerName  // If trainer name is empty, throw error
                    }
                } while trainerName.isEmpty

                // Create FitnessClass instance and add to gym
                let newService = try FitnessClass(id: id, trainingType: trainingType, totalSessions: totalSessions, price: price, duration: duration, trainerName: trainerName)
                try gym.addService(newService)
                print("A Fitness service added successfully.")

            } else {
                // For PersonalTraining service
                var trainerName: String
                repeat {
                    print("Enter trainer name: ", terminator: "")
                    trainerName = readLine() ?? ""
                    if trainerName.isEmpty {
                        throw ServiceError.invalidTrainerName  // If trainer name is empty, throw error
                    }
                } while trainerName.isEmpty

                var sessionTime: String
                repeat {
                    print("Enter session time: ", terminator: "")
                    sessionTime = readLine() ?? ""
                    if sessionTime.isEmpty {
                        throw ServiceError.invalidSessionTime  // If session time is empty, throw error
                    }
                } while sessionTime.isEmpty

                // Create PersonalTraining instance and add to gym
                let newService = try PersonalTraining(id: id, trainingType: trainingType, totalSessions: totalSessions, price: price, trainerName: trainerName, sessionTime: sessionTime)
                try gym.addService(newService)
                print("A personal training service added successfully.")
            }

            // If service is created successfully, set the flag to exit the loop
            isValidServiceCreated = true

        } catch let error as ServiceError {
            // Handle specific ServiceError
            switch error {
            case .invalidId:
                print("Error: ID cannot be empty.")
            case .invalidTrainningType:
                print("Error: Training type cannot be empty.")
            case .invalidSessions:
                print("Error: The number of sessions must be greater than zero.")
            case .invalidPrice:
                print("Error: The price must be a positive number.")
            case .invalidDuration:
                print("Error: Duration cannot be negative.")
            case .invalidTrainerName:
                print("Error: Trainer name cannot be empty.")
            case .invalidSessionTime:
                print("Error: Session time must be filled.")
            }
        } catch {
            print("An unexpected error occurred.")
        }
    } while !isValidServiceCreated  // Repeat until a valid service is created
}

// Function for searching services by keyword
func searchForService() {
    print("Enter search keyword: ", terminator: "")
    guard let keyword = readLine(), !keyword.isEmpty else {
        print("Invalid keyword. Please try again.")
        return
    }
    
    // Search the gym for services that match the keyword in their training type
    let results = gym.searchService(keyword: keyword)
    if results.isEmpty {
        print("No services found matching the keyword.")
    } else {
        print("Search results:")
        for service in results {
            print(service.serviceInfo)  // Display information about each matching service
        }
    }
}


print("Welcome to the Gym Owner Menu System!")
gymOwnerMenu()  // Start the gym owner menu interaction
