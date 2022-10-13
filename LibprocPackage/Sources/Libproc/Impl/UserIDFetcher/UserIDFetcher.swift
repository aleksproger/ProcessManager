import Foundation

protocol UserIDFetcher {
    func getUserID() -> Result<uid_t, Error>
}
