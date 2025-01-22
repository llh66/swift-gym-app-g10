//
//  MemberError.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-20.
//

import Foundation

enum MemberError: Error {
    case invalidName
    case invalidAmount
    case insufficientBalance
    case invalidService
    case duplicateBooking
    case attendedService
}
