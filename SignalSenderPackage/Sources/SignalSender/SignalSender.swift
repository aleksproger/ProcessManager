import Foundation

public protocol SignalSender {
    func send(_ signal: Int32, to id: Int32)
}