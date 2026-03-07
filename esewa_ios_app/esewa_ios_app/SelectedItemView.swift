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
        ScrollView {
            VStack(alignment: .leading) {
                // Centered image
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: item["image"] as? String ?? "")) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 300)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 300)
                    }
                    Spacer()
                }
                .padding(.bottom, 40)

                Text("\(item["title"] as? String ?? "")")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Product Category")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.bottom, 1)

                Text("\(item["category"] as? String ?? "")")
                    .font(.system(size: 14))
                    .padding(.bottom, 10)

                Text("Product Description")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.bottom, 1)

                Text("\(item["description"] as? String ?? "")")
                    .font(.system(size: 14))
                    .padding(.bottom, 20)

                Text("Total Price: $\(item["price"] as? String ?? "")")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                HStack {
                    Spacer()
                    Button {} label: {
                        Text("Pay")
                            .foregroundStyle(Color("buttonTextColor"))
                            .padding(.all, 10)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("primary"))
                    .frame(height: 52)

                    Spacer()
                }
                .padding(.top, 30)
            }

            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
}
