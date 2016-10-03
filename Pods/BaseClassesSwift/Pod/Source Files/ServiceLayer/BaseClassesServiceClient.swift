//
//  ScrubTechServiceClient.swift
//  Scrub Tech
//
//  Created by William Hindenburg on 11/13/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper
import Alamofire

public class BaseClassesServiceClient: NSObject {
    private var errorDomain = "ScrubTech.ErrorDomain"
    public func postObject<Service:BaseClassesService, PostObject:BaseModel, ResponseObject:BaseModel>(object:PostObject, andService:Service, successBlock:(ResponseObject -> Void), errorBlock:(NSError -> Void)) {
        let JSONDictionary = Mapper().toJSON(object)
        var postDictionary = [String: AnyObject]()
        if let rootRequestKeyPath = andService.rootRequestKeyPath {
            postDictionary = [rootRequestKeyPath: JSONDictionary]
        } else {
            postDictionary = JSONDictionary
        }
        
        let request = Alamofire.request(.POST, andService, parameters: postDictionary, encoding: .JSON, headers: self.authenticationHeaders())
        request.validate()
        request.responseObject(andService.rootKeyPath) { (response: Response<ResponseObject, NSError>) -> Void in
            let mappedObject = response.result.value
            if mappedObject != nil {
                successBlock(mappedObject!)
                
            } else {
                request.responseObject { (response: Response<ResponseObject, NSError>) -> Void in
                    let mappedObject = response.result.value
                    if mappedObject != nil {
                        let error = self.checkForErrorInObject(response.result.value!)
                        if error != nil {
                            errorBlock(response.result.error!)
                            return
                        } else {
                            successBlock(mappedObject!)
                        }
                    } else {
                        errorBlock(response.result.error!)
                    }
                }
            }
            
        }
    }
    
    public func putObject<Service:BaseClassesService, PostObject:BaseModel, ResponseObject:BaseModel>(object:PostObject, andService:Service, successBlock:(ResponseObject -> Void), errorBlock:(NSError -> Void)) {
        let JSONDictionary = Mapper().toJSON(object)
        var postDictionary = [String: AnyObject]()
        if let rootRequestKeyPath = andService.rootRequestKeyPath {
            postDictionary = [rootRequestKeyPath: JSONDictionary]
        } else {
            postDictionary = JSONDictionary
        }
        
        let request = Alamofire.request(.PUT, andService, parameters: postDictionary, encoding: .JSON, headers: self.authenticationHeaders())
        request.validate()
        request.responseObject(andService.rootKeyPath) { (response: Response<ResponseObject, NSError>) -> Void in
            let mappedObject = response.result.value
            if mappedObject != nil {
                successBlock(mappedObject!)
                
            } else {
                request.responseObject { (response: Response<ResponseObject, NSError>) -> Void in
                    let mappedObject = response.result.value
                    if mappedObject != nil {
                        let error = self.checkForErrorInObject(response.result.value!)
                        if error != nil {
                            errorBlock(error!)
                            return
                        } else {
                            successBlock(mappedObject!)
                        }
                    } else {
                        errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An error has occured, please try again later"]))
                    }
                }
            }
            
        }
    }
    
    public func getObject<Service:BaseClassesService, ResponseObject:BaseModel>(service:Service, successBlock:(ResponseObject -> Void), errorBlock:(NSError -> Void)) {

        let request = Alamofire.request(.GET, service, parameters: nil, encoding: .JSON, headers: self.authenticationHeaders())
        request.validate()
        request.responseObject(service.rootKeyPath) { (response: Response<ResponseObject, NSError>) -> Void in
                let mappedObject = response.result.value
                if mappedObject != nil {
                    successBlock(mappedObject!)
                    
                } else {
                    request.responseObject { (response: Response<ResponseObject, NSError>) -> Void in
                        let mappedObject = response.result.value
                        if mappedObject != nil {
                            let error = self.checkForErrorInObject(response.result.value!)
                            if error != nil {
                                errorBlock(error!)
                                return
                            } else {
                                successBlock(mappedObject!)
                            }
                        } else {
                            errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An error has occured, please try again later"]))
                        }
                    }
                }
        }
    }
    
    public func getObjects<Service:BaseClassesService, ResponseObject:BaseModel>(service:Service, successBlock:([ResponseObject] -> Void), errorBlock:(NSError -> Void)) {
        
        let request = Alamofire.request(.GET, service, parameters: nil, encoding: .JSON, headers: self.authenticationHeaders())
        request.validate()
        request.responseArray(service.rootKeyPath) { (response: Response<[ResponseObject], NSError>) -> Void in
            print(response.response)
            print(response.result.error?.userInfo)
            print (response.result.error?.localizedDescription)
            let mappedObject = response.result.value
            if mappedObject != nil {
                successBlock(mappedObject!)
                
            } else {
                request.responseArray { (response: Response<[ResponseObject], NSError>) -> Void in
                    let mappedObject = response.result.value
                    if mappedObject != nil {
                        successBlock(mappedObject!)
                    } else {
                        if self.sessionRefreshRequired(response.data) {
                            errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Token Refresh Required"]))
                        } else {
                           errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An error has occured, please try again later"]))
                        }
                        errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An error has occured, please try again later"]))
                    }
                }
            }
        }
    }
    
    private func authenticationHeaders() -> [String: String] {
        var httpHeaders = [String: String]()
        
        let userSessionToken = User.persistentUserObject().idToken as String
        httpHeaders["Authorization"] = userSessionToken
        
        if let AWSAPIKey = NSBundle.mainBundle().infoDictionary?["AWSAPIKey"] as? String {
            httpHeaders["x-api-key"] = AWSAPIKey
        } else {
            assertionFailure("Provide a AWS API Key in the info PLIST file")
        }
        
        return httpHeaders
    }
    
    private func checkForErrorInObject(object:BaseModel) -> NSError? {
        return NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong, please try again"])
    }
    
    private func sessionRefreshRequired(data:NSData?) -> Bool {
        if let updatedData = data {
            if let object = try? NSJSONSerialization.JSONObjectWithData(updatedData, options: []) {
                print(object)
                if let dictionary = object as? Dictionary<String, String> {
                    if let errorMessage = dictionary["message"] {
                        if errorMessage == "Identity token has expired" {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
}
