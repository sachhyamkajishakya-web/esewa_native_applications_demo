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

    var body: some View {
        Group {
            if engineReady {
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

            // ✅ now safe to show Flutter view
            engineReady = true
        }
    }
}
