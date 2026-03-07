//
//  SelectedItemView.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 07/03/2026.
//

import SwiftUI

struct SelectedItemView: View {
    let item: [String: Any]

    var body: some View {
        VStack(spacing: 20) {
            Text("Selected Item")
                .font(.title)
                .fontWeight(.bold)

            Text("Title: \(item["title"] as? String ?? "")")
            Text("Price: \(item["price"] as? String ?? "")")
            Text("ID: \(item["id"] as? String ?? "")")
        }
        .padding()
    }
}
