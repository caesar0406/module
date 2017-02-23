//
//  SigninPostData.swift
//  YCMessage
//
//  Created by Truck Liu on 2016/4/20.
//  Copyright © 2016年 EverTrustMac. All rights reserved.
//

import Foundation
class SignPostData: NSObject {
    
    var accessToken : String!
    var signType : String!
    var longitude : String!
    var latitude : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        accessToken = dictionary["AccessToken"] as? String
        signType = dictionary["SignType"] as? String
        longitude = dictionary["Longitude"] as? String
        latitude = dictionary["Latitude"] as? String
    }
    override init() {
        
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> Dictionary<String,AnyObject>
    {
        var dictionary = Dictionary<String,AnyObject>()
        if accessToken != nil{
            dictionary["AccessToken"] = accessToken as AnyObject?
        }
        if signType != nil{
            dictionary["SignType"] = signType as AnyObject?
        }
        if longitude != nil{
            dictionary["Longitude"] = longitude as AnyObject?
        }
        if latitude != nil{
            dictionary["Latitude"] = latitude as AnyObject?
        }
        return dictionary
    }
}
