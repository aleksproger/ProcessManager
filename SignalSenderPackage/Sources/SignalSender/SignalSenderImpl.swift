import Foundation
import signalBridge

public final class SignalSenderImpl: SignalSender {
  public init() {}
  
  public func send(_ signal: Int32, to id: Int32) -> Bool {
    let result = signalBridge.kill(id, signal)
    NSLog("XPCDebug: Sent signal(\(signal)) to PID(\(id)). Result is \(result)")
    switch result {
      case 0:
        return true
      default:
        return false
    }
  }
}
