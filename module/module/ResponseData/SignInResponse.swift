//
//	SignInResponse.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class SignInResponse{

	var accessToken : String!
	var statusCode : String!
    var statusMsg : String!
    

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		accessToken = dictionary["AccessToken"] as? String
		statusCode = dictionary["StatusCode"] as? String
        statusMsg = dictionary["StatusMsg"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if accessToken != nil{
			dictionary["AccessToken"] = accessToken
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