//
//  FlutterLaunchView.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 06/03/2026.
//

import SwiftUI

struct FlutterLaunchView: View {
    let uuid: String?
    let engineManager = FlutterEngineManager.shared
    @State private var engineReady = false
    @State private var selectedItem: [String: Any]? = nil
    @State private var showNativeDetail = false

    var body: some View {
        Group {
            if showNativeDetail, let item = selectedItem {
                // ✅ native screen with selected item
                SelectedItemView(item: item)
            } else if engineReady {
                // ✅ only create wrapper after engine is running
                FlutterViewControllerWrapper(engine: engineManager.flutterEngine)
                    .ignoresSafeArea()
            } else {
                //  show loading while engine starts
                ZStack {
                    Color.white.ignoresSafeArea()
                    VStack(spacing: 16) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                        Text("Loading...")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
        }
        .onAppear {
            // ✅ start engine first
            engineManager.start()

            // ✅ set config
            engineManager.bridge?.pendingConfig = [
                "uuid": uuid as Any,
                "platform": "ios",
                "environment": "develop"
            ]

            // ✅ listen for item selection from Flutter
            engineManager.bridge?.onItemSelected = { item in
                DispatchQueue.main.async {
                    self.selectedItem = item
                    self.showNativeDetail = true
                }
            }

            // ✅ now safe to show Flutter view
            engineReady = true
        }
    }
}
