import Flutter
import GetID
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let getIDChannel = FlutterMethodChannel(name: "samples.getid.dev/getid",
                                                binaryMessenger: controller.binaryMessenger)
        getIDChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "launchGetID" else {
                result(FlutterMethodNotImplemented)
                return
            }
            guard let (apiURL, token, flowName) = self?.getArguments(call: call, result: result) else {
                return
            }
            self?.launchGetID(apiURL: apiURL, token: token, flowName: flowName, result: result)
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getArguments(call: FlutterMethodCall, result: @escaping FlutterResult) -> (apiURL: String, token: String, flowName: String)? {
        guard let arguments = call.arguments as? [String: String] else {
            result(FlutterError(code: "Unexpected arguments", message: "arguments type should be [String: String]", details: nil))
            return nil
        }
        guard let apiURL = arguments["apiURL"] else {
            result(FlutterError(code: "Missing argument", message: "apiURL argument is missing", details: nil))
            return nil
        }
        guard let token = arguments["token"] else {
            result(FlutterError(code: "Missing argument", message: "token argument is missing", details: nil))
            return nil
        }
        guard let flowName = arguments["flowName"] else {
            result(FlutterError(code: "Missing argument", message: "flowName argument is missing", details: nil))
            return nil
        }
        return (apiURL, token, flowName)
    }

    private func launchGetID(apiURL: String, token: String, flowName: String, result: @escaping FlutterResult) {
        GetIDSDK.startVerificationFlow(
            apiUrl: apiURL,
            auth: .jwt(token),
            flowName: flowName
        )
        result(true)
    }
}
