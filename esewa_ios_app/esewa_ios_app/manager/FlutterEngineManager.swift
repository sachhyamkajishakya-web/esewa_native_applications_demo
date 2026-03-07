//
//  FlutterEngineManager.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 06/03/2026.
//
import Flutter
import FlutterPluginRegistrant
import UIKit

class FlutterEngineManager {
    static let shared = FlutterEngineManager()
    let flutterEngine = FlutterEngine(name: "my_flutter_engine")
    private(set) var bridge: MethodChannelBridge?
    private var hasStarted = false // track state manually

    private init() {}
    func start() {
        guard !hasStarted else { return } // prevent double start
        hasStarted = true
        flutterEngine.run(withEntrypoint: nil)
        GeneratedPluginRegistrant.register(with: flutterEngine)
        bridge = MethodChannelBridge(engine: flutterEngine)
        print("Engine started and bridge ready")
    }
}
