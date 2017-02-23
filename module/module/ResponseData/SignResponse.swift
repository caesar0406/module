//
//  SignResponse.swift
//  YCMessage
//
//  Created by Truck Liu on 2016/4/20.
//  Copyright © 2016年 EverTrustMac. All rights reserved.
//

import Foundation

class SignResponse{
    
    var message : String!
    var statusCode : String!
    var statusMsg : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        message = dictionary["Message"] as? String
        statusCode = dictionary["StatusCode"] as? String
        statusMsg = dictionary["StatusMsg"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if message != nil{
            dictionary["Message"] = message
        }
        if statusCode != nil{
            dictionary["StatusCode"] = statusCode
        }
        if statusMsg != nil{
            dictionary["StatusMsg"] = statusMsg
        }
        return dictionary
    }
    
}