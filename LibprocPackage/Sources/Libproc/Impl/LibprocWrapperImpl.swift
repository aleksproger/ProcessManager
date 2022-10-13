//
//  LibProcWrapperImpl.swift
//  libprocBridge
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation
import libprocBridge

final class LibprocWrapperImpl: LibprocWrapper {
  private let userIDFetcher: UserIDFetcher

  init(userIDFetcher: UserIDFetcher) {
    self.userIDFetcher = userIDFetcher
  }

  func allPids() -> Result<[Int], Error> {
    pids(.all, 0)
  }
  
  func userPids() -> Result<[Int], Error> {
    do {
      let userID = try userIDFetcher.getUserID().get()
      return .success(try pids(.uid, userID).get())
    } catch {
      return .failure(error)
    }
  }
  
  func name(for pid: Int) -> Result<String, Error> {
    var buffer = [CChar](
      repeating: 0,
      count: MemoryLayout.size(ofValue: proc_bsdinfo().pbi_name)
    )
    let bufferSize = proc_name(
      Int32(pid),
      &buffer,
      UInt32(buffer.count)
    )
    
    guard bufferSize > 0 else {
      return .failure(LibprocError.incorrectBuffer(size: bufferSize))
    }
    
    return .success(String(cString: buffer))
  }
  
  public func pids(
    _ type: PidsType,
    _ typeInfo: UInt32
  ) -> Result<[Int], Error> {
    let rawType = UInt32(type.rawValue)
    var bufferSize = proc_listpids(rawType, typeInfo, nil, 0)
    
    guard bufferSize >= 0 else {
      return .failure(LibprocError.incorrectBuffer(size: bufferSize))
    }
    
    guard bufferSize > 0 else {
      return .success([])
    }
    
    let pidSize = MemoryLayout<pid_t>.stride
    var pids = [pid_t](repeating: 0, count: Int(bufferSize) / pidSize)
    bufferSize = proc_listpids(
      rawType,
      typeInfo,
      &pids,
      bufferSize
    )
    
    guard bufferSize >= 0 else {
      return .failure(LibprocError.incorrectBuffer(size: bufferSize))
    }
    
    return .success(pids[0..<Int(bufferSize) / pidSize].map { id in
      Int(id)
    })
  }
}
