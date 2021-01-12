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
            guard let (apiURL, token) = self?.getTokenAndApiURL(call: call, result: result) else {
                return
            }
            self?.launchGetID(apiURL: apiURL, token: token, result: result)
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getTokenAndApiURL(call: FlutterMethodCall, result: @escaping FlutterResult) -> (apiURL: String, token: String)? {
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
        return (apiURL, token)
    }

    private func launchGetID(apiURL: String, token: String, result: @escaping FlutterResult) {
        GetIDFactory.makeGetIDViewController(token: token, url: apiURL) { [weak self] vc, error in
            guard let viewController = vc else {
                return result(FlutterError(code: "GetID Error", message: "Something went wrong: \(error!)", details: nil))
            }
            self?.window?.rootViewController?.present(viewController, animated: true, completion: nil)
            result(true)
        }
    }
}
