//
//  Member.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-16.
//

import Foundation

class Member {
    static var count: Int = 0
    let id: String
    let name: String
    var creditBalance: Double = 100
    var bookedServices = [String: [String: Int]]()
    var gym: Gym
    
    init(name: String, gym: Gym) throws {
        guard !name.isEmpty, name.first != " ", name.last != " " else {
            throw MemberError.invalidName
        }
        self.id = String(Member.count)
        Member.count += 1
        self.name = name
        self.gym = gym
    }
    
    func bookService(_ id: String) throws {
        guard let service = gym.services[id] else {
            throw MemberError.invalidService
        }
        
        if let _ = bookedServices[id] {
            throw MemberError.duplicateBooking
        }
        
        guard self.creditBalance >= service.price else {
            throw MemberError.insufficientBalance
        }
        
        self.bookedServices[id] = ["totalSessions": service.totalSessions, "attendedSessions": 0]
            creditBalance -= service.price
        print("\nThank you! Service \(service.id) booked. Receipt:")
        service.printReceipt(transactionType: "Purchase", amount: service.price)
    }
    
    func cancelService(_ id: String) throws {
        if let serviceHistory = bookedServices[id] {
            guard serviceHistory["attendedSessions"]! == 0 else {
                throw MemberError.attendedService
            }
            
            self.bookedServices.removeValue(forKey: id)
            self.creditBalance += gym.services[id]!.price
            print("\nService \(id) cancelled. Receipt:")
            gym.services[id]!.printReceipt(transactionType: "Refund", amount: gym.services[id]!.price)
        }
        else {
            throw MemberError.invalidService
        }
    }
    
    func viewBookedService() {
        if bookedServices.count == 0 {
            print("\nNo services booked yet.")
            return
        }
        
        print("\nBooked service(s): ")
        
        for (id, bookedService) in bookedServices {
            print([
                "service": gym.services[id]!.serviceInfo,
                "attended sessions": bookedService["attendedSessions"]!
                  ])
        }
    }
    
    func checkBalance() -> String {
        return "Credit Balance: $\(round(creditBalance * 100) / 100)"
    }
    
    func reloadCreditBalance(by amount: Double) throws {
        guard amount > 0 else {
            throw MemberError.invalidAmount
        }
        
        creditBalance += amount
        print("\nNew " + self.checkBalance())
    }
    
    func markAttendence(_ id: String) throws {
        if let bookedService = bookedServices[id] {
            self.bookedServices[id]!["attendedSessions"]! += 1
            print("\nAttended \(id), progress: ")
            print([
                "service id": id,
                "total sessions": self.bookedServices[id]!["totalSessions"]!,
                "attended sessions": self.bookedServices[id]!["attendedSessions"]!])
            if self.bookedServices[id]!["attendedSessions"]! == self.bookedServices[id]!["totalSessions"]! {
                print("Congrats on completing all sessions!")
                self.bookedServices.removeValue(forKey: id)
            }
        }
        else {
            throw MemberError.invalidService
        }
    }
}
