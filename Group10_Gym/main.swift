//
//  main.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-20.
//

import Foundation

// Initialize a Gym object to store all gym services
let gym = Gym()

// Adding some initial services to the gym
do {
    try gym.addService(FitnessClass(id: "0077GY", trainingType: "Pilates", totalSessions: 10, price: 50.0, duration: 60, trainerName: "Kenny Smith"))
    
    try gym.addService(FitnessClass(id: "ABCXYZ", trainingType: "Stretching", totalSessions: 8, price: 40.0, duration: 45, trainerName: "Josh Allen"))
    
    try gym.addService(PersonalTraining(id: "PT2011", trainingType: "Weight Training", totalSessions: 5, price: 100.0, trainerName: "Michael B Jordan", sessionTime: "10:00 AM"))
} catch {
    // If there is an error while adding the services, print the error
    print("Error adding initial services: \(error)")
}

// Function to display the Gym Owner menu and interact with the user
func gymOwnerMenu() {
    while true {
        // Display the options for the gym owner
        print("\nGym Owner Menu:")
        print("1. Create new service")
        print("2. Search for service")
        print("3. List all services")
        print("4. Exit")
        print("Enter your choice: ", terminator: "")
        
        // Read input from the owner for the menu choice
        guard let choice = readLine(), let option = Int(choice) else {
            print("Invalid input. Please try again.")
            continue
        }
        
        // Switch statement to handle the owner's choice
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
            print("Invalid option. Please try again.")  // Handle invalid menu options
        }
    }
}

// Function to handle creation of a new service (Fitness Class or Personal Training)
func createNewService() {
    var serviceType: Int?
    repeat {
        // Prompt for the service type (Fitness Class or Personal Training)
        print("Enter service type (1 for Fitness Class, 2 for Personal Training): ", terminator: "")
        
        // Read input and check if it's valid (1 or 2)
        if let typeChoice = readLine(), let inputType = Int(typeChoice), (inputType == 1 || inputType == 2) {
            serviceType = inputType  // Store the selected service type
        } else {
            print("Error: Invalid choice. Please enter 1 for Fitness Class or 2 for Personal Training.")
        }
    } while serviceType == nil

    var isValidServiceCreated = false
    repeat {
        do {
            // Collect service ID
            var id: String
            repeat {
                print("Enter service ID: ", terminator: "")
                id = readLine() ?? ""
                if id.isEmpty {
                    throw ServiceError.invalidId  // Raise an error if ID is empty
                }
            } while id.isEmpty

            // Collect training type
            var trainingType: String
            repeat {
                print("Enter training type: ", terminator: "")
                trainingType = readLine() ?? ""
                if trainingType.isEmpty {
                    throw ServiceError.invalidTrainningType
                }
            } while trainingType.isEmpty
            var totalSessions: Int = 0
            repeat {
                print("Enter total number of sessions: ", terminator: "")
                if let inputSessions = Int(readLine() ?? ""), inputSessions > 0 {
                    totalSessions = inputSessions  // Store the valid number of sessions
                } else {
                    throw ServiceError.invalidSessions  // Raise an error if input is invalid
                }
            } while totalSessions <= 0  // Repeat until valid number of sessions is provided

            // Collect price of the service
            var price: Double = 0.0
            repeat {
                print("Enter price: ", terminator: "")
                if let inputPrice = Double(readLine() ?? ""), inputPrice > 0 {
                    price = inputPrice  // Store the valid price
                } else {
                    throw ServiceError.invalidPrice
                }
            } while price <= 0

            // If FitnessClass service is selected, collect specific details
            if serviceType == 1 {
                var duration: Int = 0
                repeat {
                    print("Enter duration (in minutes): ", terminator: "")
                    if let inputDuration = Int(readLine() ?? ""), inputDuration > 0 {
                        duration = inputDuration  // Store valid duration
                    } else {
                        throw ServiceError.invalidDuration
                    }
                } while duration <= 0

                // Collect trainer's name for FitnessClass
                var trainerName: String
                repeat {
                    print("Enter trainer name: ", terminator: "")
                    trainerName = readLine() ?? ""
                    if trainerName.isEmpty {
                        throw ServiceError.invalidTrainerName
                    }
                } while trainerName.isEmpty  // Repeat until trainer name is provided

                // Create a new FitnessClass instance and add it to the gym
                let newService = try FitnessClass(id: id, trainingType: trainingType, totalSessions: totalSessions, price: price, duration: duration, trainerName: trainerName)
                try gym.addService(newService)  // Add service to the gym
                print("A Fitness service added successfully.")

            } else {
                // If PersonalTraining service is selected, collect specific details
                var trainerName: String
                repeat {
                    print("Enter trainer name: ", terminator: "")
                    trainerName = readLine() ?? ""
                    if trainerName.isEmpty {
                        throw ServiceError.invalidTrainerName
                    }
                } while trainerName.isEmpty  // Repeat until trainer name is provided

                // Collect session time for PersonalTraining
                var sessionTime: String
                repeat {
                    print("Enter session time: ", terminator: "")
                    sessionTime = readLine() ?? ""
                    if sessionTime.isEmpty {
                        throw ServiceError.invalidSessionTime
                    }
                } while sessionTime.isEmpty  // Repeat until session time is provided

                // Create a new PersonalTraining instance and add it to the gym
                let newService = try PersonalTraining(id: id, trainingType: trainingType, totalSessions: totalSessions, price: price, trainerName: trainerName, sessionTime: sessionTime)
                try gym.addService(newService)  // Add service to the gym
                print("A personal training service added successfully.")
            }

            // If service is successfully created, exit the loop
            isValidServiceCreated = true

        } catch let error as ServiceError {
            // Catch specific service-related errors and print corresponding messages
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
            // Catch any other unexpected errors
            print("An unexpected error occurred.")
        }
    } while !isValidServiceCreated  // Repeat until a valid service is created
}

// Function to search for a service in the gym by keyword
func searchForService() {
    // Prompt user for a search keyword
    print("Enter search keyword: ", terminator: "")
    guard let keyword = readLine(), !keyword.isEmpty else {
        print("Invalid keyword. Please try again.")
        return
    }
    
    // Search for services in the gym by the keyword
    let results = gym.searchService(keyword: keyword)
    if results.isEmpty {
        print("No services found matching the keyword.")
    } else {
        print("Search results:")
        for service in results {
            print(service.serviceInfo)
        }
    }
}

// Start the program and show the gym owner menu
print("Welcome to the Gym Owner Menu System!")
gymOwnerMenu()
