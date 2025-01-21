//
//  ServiceError.swift
//  Group10_Gym
//
//  Created by David Dang on 2025-01-21.
//

import Foundation

enum ServiceError: Error {
    case invalidId
    case invalidTrainningType
    case invalidSessions
    case invalidPrice
    case invalidDuration
    case invalidTrainerName
    case invalidSessionTime
}
