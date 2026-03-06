//
//  MethodChannelBridge.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 06/03/2026.
//

import Flutter

class MethodChannelBridge {
    static let channelName = "com.example.esewa_ios/config"

    private let channel: FlutterMethodChannel
    var pendingConfig: [String: Any]?

    init(engine: FlutterEngine) {
        channel = FlutterMethodChannel(
            name: MethodChannelBridge.channelName,
            binaryMessenger: engine.binaryMessenger
        )
        setupHandlers()
    }

    private func setupHandlers() {
        print("4️⃣ Handler registered, waiting for flutterReady...")
        channel.setMethodCallHandler { [weak self] call, result in
            print("5️⃣ Received call: \(call.method)")
            switch call.method {
            case "flutterReady":
                print("6️⃣ Flutter is ready! pendingConfig: \(String(describing: self?.pendingConfig))")
                if let config = self?.pendingConfig {
                    self?.sendDataToFlutter(method: "appConfig", arguments: config)
                    self?.pendingConfig = nil
                } else {
                    print("⚠️ pendingConfig is nil — config was not set before flutterReady!")
                }
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    func sendDataToFlutter(method: String, arguments: Any?) {
        print("7️⃣ Sending to Flutter — method: \(method), args: \(String(describing: arguments))")
        channel.invokeMethod(method, arguments: arguments) { result in
            if let error = result as? FlutterError {
                print("❌ Flutter error: \(error.message ?? "unknown")")
            } else if FlutterMethodNotImplemented.isEqual(result) {
                print("❌ Method not implemented in Flutter")
            } else {
                print("✅ Flutter responded: \(String(describing: result))")
            }
        }
    }
}
