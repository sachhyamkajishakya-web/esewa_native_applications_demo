//
//  FlutterViewController+SwiftUI.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 06/03/2026.
//

import Flutter
import SwiftUI

struct FlutterViewControllerWrapper: UIViewControllerRepresentable {
    let engine: FlutterEngine

    func makeUIViewController(context: Context) -> FlutterViewController {
        return FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {}
}
