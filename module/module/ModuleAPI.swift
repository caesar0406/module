//
//  ModuleAPI.swift
//  module
//
//  Created by Truck on 2017/2/22.
//  Copyright © 2017年 Truck. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony
import Alamofire

enum StatusCode {
    case correct, nonCompetence, adValidationFails, idisEmpty, pwdisEmpty, serverError
    func returnCode() -> String {
        switch self {
        case .correct:
            return "0"
        case .nonCompetence:
            return "-10001"
        case .adValidationFails:
            return "-10002"
        case .idisEmpty:
            return "-10003"
        case .pwdisEmpty:
            return "-10004"
        case .serverError:
            return "-10099"
        }
    }
}

class ModuleAPI: NSObject {
    class var sharedInstance: ModuleAPI {
        struct Static {
            static let instance: ModuleAPI = ModuleAPI()
        }
        return Static.instance
        
    }
    
    // MARK: - 登入
    func signIn(_ SignInID: String, Password: String, completionHandler: @escaping (_ signInResponse: SignInResponse, _ error: NSError?) -> Void) -> Self {

        let networkInfo = CTTelephonyNetworkInfo()
        var carrierName = ""
        if let carrier = networkInfo.subscriberCellularProvider {
            if let name = carrier.carrierName {
                carrierName = name // 電信商名稱
            }
        }
        var appVersion = ""
        if let ver = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            appVersion = ver // Build version
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        // Device model
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let systemVersion = "\(UIDevice.current.systemVersion)|Apple|\(identifier)|\(carrierName)|\(appVersion)"
        print(systemVersion)
        // OS version | Device provider(Apple) | Device model | 通信業者 | build version
        //get a unique device ID in Swift
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        var pushNotificationToken = ""
        if UserDefaults.standard.string(forKey: "deviceToken") != nil {
            pushNotificationToken = UserDefaults.standard.string(forKey: "deviceToken")!
        }
        
        let parameters = ["SignInID": "\(SignInID)", "Password": "\(Password)", "DeviceModel": "\(systemVersion)", "DeviceID": "\(deviceID)", "PNToken": "\(pushNotificationToken)", "AppType": "1"]
        request(Router.signIn(parameters as [String : AnyObject])).responseJSON { response in
            if let content = response.result.value as! NSDictionary? {
                let signInResponse:SignInResponse = SignInResponse(fromDictionary: content )
                completionHandler(signInResponse, response.result.error as NSError?)
                if signInResponse.statusCode == "0" {
                    //設定AccessToken
                    UserDefaults.standard.set(signInResponse.accessToken!, forKey: "AccessToken")
                }
            } else {
                if response.result.error != nil {
                    //server error
                    completionHandler(SignInResponse(fromDictionary: ["StatusCode":"500"]), response.result.error as NSError?)
                }
            }
        }
        return self
    }

    // MARK: - 簽到退
    func sign(_ signType: String, longitude: String, latitude: String, completionHandler: @escaping (_ signResponse: SignResponse, _ error: NSError?) -> Void) -> Self {
        guard let accessToken = UserDefaults.standard.string(forKey: "AccessToken") else {
            completionHandler(SignResponse(fromDictionary: ["StatusCode":"500"]), nil )
            return self
        }
        let parameters = ["AccessToken": accessToken, "SignType": signType, "Longitude": longitude, "Latitude": latitude]
        request(Router.sign(parameters as [String : AnyObject])).responseJSON { response in
            let signResponse: SignResponse!
            if let content = response.result.value as! NSDictionary? {
                signResponse = SignResponse(fromDictionary: content as NSDictionary)
                completionHandler(signResponse, response.result.error as NSError?)
            } else {
                completionHandler(SignResponse(fromDictionary: ["StatusCode":"500"]), response.result.error as NSError?)
            }
        }
        return self
    }
}
