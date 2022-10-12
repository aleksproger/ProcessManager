//
//  ContentView.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import SwiftUI
import ProcessListToAppShared

struct ContentView: View {
  @EnvironmentObject var dependencies: DependenciesContainer
  @State var category: CategoryType? = .allProcesses
  
  var body: some View {
    NavigationView {
      SidebarView(selection: $category)
        .frame(width: 200)
      
      switch category {
        case .allProcesses,
            .none:
          TableView(
            viewModel: TableVewModel(
              onProcessTap: dependencies.processKiller.kill(withID:),
              processesPublished: dependencies.allProcessesPublished
            )
          )
        case .userOwnedProcesses:
          TableView(
            viewModel: TableVewModel(
              onProcessTap: dependencies.processKiller.kill(withID:),
              processesPublished: dependencies.userOwnedPublished
            )
          )
      }
    }
    .frame(
      minWidth: 700,
      idealWidth: 1000,
      maxWidth: .infinity,
      minHeight: 400,
      idealHeight: 800,
      maxHeight: .infinity
    )
    .navigationTitle("ProcessManager")
    .toolbar { Toolbar() }
  }
}
