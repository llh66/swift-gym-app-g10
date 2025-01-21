import Foundation

// Protocol defining that a class must be "purchasable", meaning it should have some service information and be able to print a receipt.
protocol IsPurchasable {
    var serviceInfo: String { get }
    func printReceipt(transactionType: String, amount: Double)
}

// Default implementation of the `printReceipt` method for any class or struct that conforms to `IsPurchasable`.
extension IsPurchasable {
    func printReceipt(transactionType: String, amount: Double) {
        print(serviceInfo)
        print("Amount: $\(amount)")
        print("Date: \(Date())")
        print("--------------------")
    }
}
