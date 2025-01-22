//
//  IsPurchasable.swift
//  Group10_Gym
//
//  Created by LLH on 2025-01-16.
//
import Foundation

// Protocol defining that a class must be "purchasable", meaning it should have some service information and be able to print a receipt.
protocol IsPurchasable {
    var serviceInfo: [String: Any] { get }
    func printReceipt(transactionType: String, amount: Double)
}

// Default implementation of the `printReceipt` method for any class or struct that conforms to `IsPurchasable`.
extension IsPurchasable {
    func printReceipt(transactionType: String, amount: Double) {
        print(["Service": serviceInfo, "Transaction Type": transactionType, "Amount": amount, "Date": Date()])
    }
}
