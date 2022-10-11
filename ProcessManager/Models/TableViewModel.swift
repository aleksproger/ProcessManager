//
//  TableViewModel.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation
import ProcessListToAppShared
import SwiftUI
import Combine

final class TableVewModel: ObservableObject {
  @Published var processes: [ProcessModel] = []
  
  let onProcessTap: (Int) -> Void
    
  init(
    onProcessTap: @escaping (Int) -> Void,
    processesPublished: Published<[ProcessModel]>.Publisher
  ) {
    self.onProcessTap = onProcessTap
    processesPublished.assign(to: &$processes)
  }
}
