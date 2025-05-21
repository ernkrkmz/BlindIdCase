//
//  HomeTabView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import SwiftUI

struct MovieTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            LikeView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Like")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
