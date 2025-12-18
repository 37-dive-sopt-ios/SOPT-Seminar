//
//  NavigationDestinationExample.swift
//  Seminar07
//
//  Created by 이명진 on 2025.
//

import SwiftUI

// MARK: - NavigationDestinationExample

struct NavigationDestinationExample: View {

    // MARK: - Destination Enum

    enum Destination: Hashable {
        case detail
        case setting
        case profile

        var title: String {
            switch self {
            case .detail:
                "detail"
            case .setting:
                "setting"
            case .profile:
                "profile"
            }
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                NavigationLink(Destination.detail.title, value: Destination.detail)
                NavigationLink(value: Destination.setting) {
                    Text(Destination.setting.title)
                }
                NavigationLink(value: Destination.profile) {
                    Text(Destination.profile.title)
                }
            }
            .navigationTitle("메인")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .detail:
                    Text("Detail View")
                        .font(.largeTitle)
                case .setting:
                    Text("Setting View")
                        .font(.largeTitle)
                case .profile:
                    Text("Profile View")
                        .font(.largeTitle)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationDestinationExample()
}
