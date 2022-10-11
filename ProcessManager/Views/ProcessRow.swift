//
//  ProcessView.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import SwiftUI
import ProcessListToAppShared

struct ProcessRow: View {
  private let process: ProcessModel
  
  init(process: ProcessModel) {
    self.process = process
  }
  
  var body: some View {
    Text("\(process.name)(\(process.id))")
  }
}
