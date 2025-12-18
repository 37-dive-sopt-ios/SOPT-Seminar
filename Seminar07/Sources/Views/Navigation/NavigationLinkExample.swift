//
//  NavigationLinkExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - NavigationLinkExample

struct NavigationLinkExample: View {

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Teal") {
                    ColorDetail(color: .teal)
                }

                NavigationLink("Red") {
                    ColorDetail(color: .red)
                }

                NavigationLink("Blue") {
                    ColorDetail(color: .blue)
                }

                NavigationLink {
                    ColorDetail(color: .green)
                } label: {
                    Label("Work Folder", systemImage: "folder")
                }
            }
            .navigationTitle("Colors")
        }
    }
}

// MARK: - ColorDetail

struct ColorDetail: View {
    var color: Color

    var body: some View {
        color
            .ignoresSafeArea()
            .navigationTitle(color.description)
    }
}

// MARK: - Preview

#Preview {
    NavigationLinkExample()
}
