//
//  APIRequestRouter.swift
//  module
//
//  Created by Truck on 2017/2/22.
//  Copyright © 2017年 Truck. All rights reserved.
//


import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://gtwex.housefun.com.tw/EEPS/APP/YCMessage"
    static let getVersionURLString = "http://apps.evertrust.com.tw/v1/LatestVersionInfo/YCMessage/iOS"

    case signIn([String: AnyObject])
    case sign([String: AnyObject])

    var method: Alamofire.HTTPMethod {
        switch self {
        
        case .signIn:
            return Alamofire.HTTPMethod.get
        case .sign:
            return Alamofire.HTTPMethod.get
        }
    }
    
    var baseURL: String {
        switch self {
        case .signIn:
            return Router.baseURLString
        case .sign:
            return Router.baseURLString
        }
    }
    
    var path: String {
        switch self {
            
        case .signIn(_):
            return "/SignIn.ashx"
        case .sign(_):
            return "/DutyCard.ashx"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .signIn(let parameters):
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .sign(let parameters):
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
