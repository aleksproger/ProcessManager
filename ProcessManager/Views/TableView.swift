//
//  TableView.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import SwiftUI
import Combine
import ProcessListToAppShared

struct TableView: View {
  @ObservedObject var viewModel: TableVewModel
  
  var body: some View {
    List {
      ForEach($viewModel.processes) { process in
        ProcessRow(process: process.wrappedValue)
          .contextMenu {
            Button(
              action: { viewModel.onProcessTap(process.id) },
              label: { Label("Kill process", systemImage: "heart.fill") }
            )
          }
      }
    }
    .listStyle(.inset(alternatesRowBackgrounds: true))
  }
}

extension ProcessModel: Identifiable {}
