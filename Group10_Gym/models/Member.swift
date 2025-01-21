//
//  Member.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-20.
//

import Foundation

class Member {
    static var count: Int = 0
    let id: String
    let name: String
    var creditBalance: Double = 0
//    var storedServices = [String: [String: Int]]()
    
    init(name: String) {
        self.id = String(Member.count)
        Member.count += 1
        self.name = name
    }
    
    //bookService
    //cancelService
    //viewBookedService
    func checkBalance() -> String {
        return "Credit Balance: $\(creditBalance)"
    }
    
    func reloadCreditBalance(_ amount: Double) throws {
        guard amount >= 0 else {
            throw MemberError.invalidAmount
        }
        
        creditBalance += round(amount * 100) / 100
    }
    //markAttendence
}
