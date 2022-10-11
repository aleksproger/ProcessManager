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
  
  var body: some View {
    NavigationView {
      
      SidebarView(selection: .constant(.processes))
        .frame(width: 200)
      
      TableView(
        viewModel: TableVewModel(
          onProcessTap: dependencies.processKiller.kill(withID:),
          processesPublished: dependencies.processesPublished.$value
        )
      )
      
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
