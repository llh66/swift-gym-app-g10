//
//  main.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-16.
//

import Foundation

// Initialize a Gym object to store all gym services
let gym = Gym()
var member: Member?

// Adding some initial services to the gym
do {
    try gym.addService(FitnessClass(id: "0077GY", trainingType: "Pilates", totalSessions: 10, price: 50.0, duration: 60, trainerName: "Kenny Smith"))
    
    try gym.addService(FitnessClass(id: "ABCXYZ", trainingType: "Stretching", totalSessions: 8, price: 40.0, duration: 45, trainerName: "Josh Allen"))
    
    try gym.addService(PersonalTraining(id: "PT2011", trainingType: "Weight Training", totalSessions: 5, price: 100.0, trainerName: "Michael B Jordan", sessionTime: "10:00 AM"))
} catch {
    // If there is an error while adding the services, print the error
    print("Error adding initial services: \(error)")
}

while true {
    print("\nWelcome to the Gym System!")
    print("1. Enter as owner")
    print("2. Enter as member")
    print("3. Exit")
    print("Enter your choice: ", terminator: "")
    if let option = Int(readLine() ?? "") {
        switch(option) {
        case 1:
            gymOwnerMenu()
        case 2:
            gymMemberMenu()
        case 3:
            exit(0)
        default:
            print("\nPlease enter 1, 2, or 3")
        }
    }
    else {
        print("\nPlease enter 1, 2, or 3")
    }
}


func gymMemberMenu() {
    while true {
        print("\nGym Member Menu:")
        print("1. Join the gym")
        print("2. Check credit points")
        print("3. Reload credit points")
        print("4. Search for service")
        print("5. List your service")
        print("6. Purchase service")
        print("7. Attend session")
        print("8. Cancel service")
        print("9. Go back")
        print("Enter your choice: ", terminator: "")
        if let option = Int(readLine() ?? ""), (option >= 1 && option <= 9) {
            if option != 1, option != 9, member == nil {
                print("\nPlease join the gym first")
                continue
            }
            
            switch(option) {
            case 1:
                joinTheGym()
            case 2:
                print(member!.checkBalance())
            case 3:
                reloadCreditPoints()
            case 4:
                searchForService()
            case 5:
                member!.viewBookedService()
            case 6:
                purchaseService()
            case 7:
                attendSession()
            case 8:
                cancelService()
            case 9:
                return
            default:
                print("\nPlease enter an integer between 1 and 9")
            }
        }
        else {
            print("\nPlease enter an integer between 1 and 9")
        }
    }
}

func joinTheGym() {
    do {
        print("Please enter your name: ", terminator: "")
        if let name = readLine() {
            member = try Member(name: name, gym: gym)
            print("Welcome, \(member!.name)")
        }
    } catch {
        switch(error) {
        case MemberError.invalidName:
            print("\nInvalid name. Please try again.")
        default:
            print("\n\(error)")
        }
    }
}

func reloadCreditPoints() {
    do{
        print("Please enter the reloading amount: ", terminator: "")
        if let amount = Double(readLine() ?? "") {
            try member!.reloadCreditBalance(by: amount)
        }
        else {
            throw MemberError.invalidAmount
        }
    } catch {
        switch(error) {
        case MemberError.invalidAmount:
            print("\nInvalid input. Please enter a positive number.")
        default:
            print("\n\(error)")
        }
    }
}

func purchaseService() {
    do{
        print("Please enter the service id to purchase: ", terminator: "")
        if let id = readLine() {
            try member!.bookService(id)
            print(member!.checkBalance())
        }
    } catch {
        switch(error) {
        case MemberError.invalidService:
            print("\nService not found. Please enter a valid id.")
        case MemberError.insufficientBalance:
            print("\nInsufficient balance. Please reload first.")
        case MemberError.duplicateBooking:
            print("\nService purchased already")
        default:
            print("\n\(error)")
        }
    }
}

func attendSession() {
    do{
        print("Please enter the service id to attend: ", terminator: "")
        if let id = readLine() {
            try member!.markAttendence(id)
        }
    } catch {
        switch(error) {
        case MemberError.invalidService:
            print("\nService not found. Please enter a valid id or purchase the service first.")
        default:
            print("\n\(error)")
        }
    }
}

func cancelService() {
    do{
        print("Please enter the service id to cancel: ", terminator: "")
        if let id = readLine() {
            try member!.cancelService(id)
            print(member!.checkBalance())
        }
    } catch {
        switch(error) {
        case MemberError.invalidService:
            print("\nService not found. Please make sure it is valid or purchased.")
        case MemberError.attendedService:
            print("\nYou cannot cancel a service that has already been attended.")
        default:
            print("\n\(error)")
        }
    }
}

// Function to display the Gym Owner menu and interact with the user
func gymOwnerMenu() {
    while true {
        // Display the options for the gym owner
        print("\nGym Owner Menu:")
        print("1. Create new service")
        print("2. Search for service")
        print("3. List all services")
        print("4. Go back")
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
    // Get service type
    var serviceType: Int
    repeat {
        print("Enter service type (1 for Fitness Class, 2 for Personal Training): ", terminator: "")
        serviceType = Int(readLine() ?? "") ?? 0
        if serviceType != 1 && serviceType != 2 {
            print("Invalid service type. Please enter 1 or 2.")
        }
    } while serviceType != 1 && serviceType != 2

    // Get common service details
    let id = getValidInput("Enter service ID: ", errorType: .invalidId) { !$0.isEmpty }
    let trainingType = getValidInput("Enter training type: ", errorType: .invalidTrainningType) { !$0.isEmpty }
    let totalSessions = getValidInput("Enter total number of sessions: ", errorType: .invalidSessions) { Int($0) ?? 0 > 0 }
    let price = getValidInput("Enter price: ", errorType: .invalidPrice) { Double($0) ?? 0 > 0 }

    do {
        let newService: Service
        if serviceType == 1 {
            // Get FitnessClass specific details
            let duration = getValidInput("Enter duration (in minutes): ", errorType: .invalidDuration) { Int($0) ?? 0 > 0 }
            let trainerName = getValidInput("Enter trainer name: ", errorType: .invalidTrainerName) { !$0.isEmpty }
            // Create FitnessClass instance
            newService = try FitnessClass(id: id, trainingType: trainingType, totalSessions: Int(totalSessions)!, price: Double(price)!, duration: Int(duration)!, trainerName: trainerName)
        } else {
            // Get PersonalTraining specific details
            let trainerName = getValidInput("Enter trainer name: ", errorType: .invalidTrainerName) { !$0.isEmpty }
            let sessionTime = getValidInput("Enter session time: ", errorType: .invalidSessionTime) { !$0.isEmpty }
            // Create PersonalTraining instance
            newService = try PersonalTraining(id: id, trainingType: trainingType, totalSessions: Int(totalSessions)!, price: Double(price)!, trainerName: trainerName, sessionTime: sessionTime)
        }
        
        // Add the new service to the gym
        try gym.addService(newService)
        print("Service added successfully.")
    } catch {
             handleServiceError(error as? ServiceError ?? .invalidId)
    }
}

// Helper function to get valid input from the user
func getValidInput(_ prompt: String, errorType: ServiceError, isValid: (String) -> Bool) -> String {
    var input: String
    repeat {
        print(prompt, terminator: "")
        input = readLine() ?? ""
        if !isValid(input) {
            handleServiceError(errorType)
        }
    } while !isValid(input)
    return input
}

// Function to handle and display service-related errors
func handleServiceError(_ error: ServiceError) {
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
        print("Error: Duration must be greater than zero.")
    case .invalidTrainerName:
        print("Error: Trainer name cannot be empty.")
    case .invalidSessionTime:
        print("Error: Session time must be filled.")
    }
}


// Function to search for a service in the gym by keyword
func searchForService() {
    // Prompt user for a search keyword
    print("Enter search keyword: ", terminator: "")
    guard let keyword = readLine(), !keyword.isEmpty else {
        print("Invalid keyword. Please try again.")
        return
    }
    
    // Call the Gym's searchService method to get the formatted results
    gym.searchService(keyword: keyword)
}
