//
//  SidebarView.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import SwiftUI

struct SidebarView: View {
    @Binding var selection: CategoryType?
    
    var body: some View {
        List(selection: $selection) {
          Section("CATEGORIES") {
            ForEach(CategoryType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .bold()
            }
          }
        }
        .listStyle(.sidebar)
    }
}
