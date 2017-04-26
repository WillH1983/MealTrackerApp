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

open class BaseClassesServiceClient: NSObject {
    fileprivate var errorDomain = "ScrubTech.ErrorDomain"
    open func postObject<Service:BaseClassesService, PostObject:BaseModel, ResponseObject:BaseModel>(_ object:PostObject, andService:Service, successBlock:@escaping ((ResponseObject) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        let JSONDictionary = Mapper().toJSON(object)
        var postDictionary = Parameters()
        if let rootRequestKeyPath = andService.rootRequestKeyPath {
            postDictionary = [rootRequestKeyPath: JSONDictionary]
        } else {
            postDictionary = JSONDictionary
        }
        let request = Alamofire.request(andService, method: HTTPMethod.post, parameters: postDictionary, encoding: JSONEncoding.default, headers: self.authenticationHeaders())
        request.validate()

        request.responseObject(queue: nil, keyPath: andService.rootKeyPath) { (response: DataResponse<ResponseObject>) -> Void in
            let mappedObject = response.result.value
            if mappedObject != nil {
                successBlock(mappedObject!)
                
            } else {
                request.responseObject { (response: DataResponse<ResponseObject>) -> Void in
                    let mappedObject = response.result.value
                    if mappedObject != nil {
                        successBlock(mappedObject!)
                    } else {
                        self.handleErrorResponse(response.data, refreshCompletionBlock: { () in
                            self.postObject(object, andService: andService, successBlock: successBlock, errorBlock: errorBlock)
                        }, errorBlock: errorBlock)
                    }
                }
            }
            
        }
    }
    
    open func putObject<Service:BaseClassesService, PostObject:BaseModel, ResponseObject:BaseModel>(_ object:PostObject, andService:Service, successBlock:@escaping ((ResponseObject) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        let JSONDictionary = Mapper().toJSON(object)
        var postDictionary = [String: Any]()
        if let rootRequestKeyPath = andService.rootRequestKeyPath {
            postDictionary = [rootRequestKeyPath: JSONDictionary]
        } else {
            postDictionary = JSONDictionary
        }
        
        let request = Alamofire.request(andService, method: HTTPMethod.put, parameters: postDictionary, encoding: JSONEncoding.default, headers: self.authenticationHeaders())
        request.validate()
        request.responseObject(queue: nil, keyPath: andService.rootKeyPath) { (response: DataResponse<ResponseObject>) -> Void in
            let mappedObject = response.result.value
            if mappedObject != nil {
                successBlock(mappedObject!)
                
            } else {
                request.responseObject { (response: DataResponse<ResponseObject>) -> Void in
                    let mappedObject = response.result.value
                    if mappedObject != nil {
                        successBlock(mappedObject!)
                    } else {
                        self.handleErrorResponse(response.data, refreshCompletionBlock: { () in
                            self.putObject(object, andService: andService, successBlock: successBlock, errorBlock: errorBlock)
                        }, errorBlock: errorBlock)
                    }
                }
            }
            
        }
    }
    
    open func getObject<Service:BaseClassesService, ResponseObject:BaseModel>(_ service:Service, successBlock:@escaping ((ResponseObject) -> Void), errorBlock:@escaping ((NSError) -> Void)) {

        let request = Alamofire.request(service, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: self.authenticationHeaders())
        request.validate()
        request.responseObject(queue: nil, keyPath: service.rootKeyPath) { (response: DataResponse<ResponseObject>) -> Void in
                let mappedObject = response.result.value
                if mappedObject != nil {
                    successBlock(mappedObject!)
                } else {
                    request.responseObject { (response: DataResponse<ResponseObject>) -> Void in
                        let mappedObject = response.result.value
                        if mappedObject != nil {
                            successBlock(mappedObject!)
                        } else {
                            self.handleErrorResponse(response.data, refreshCompletionBlock: { () in
                                self.getObject(service, successBlock: successBlock, errorBlock: errorBlock)
                            }, errorBlock: errorBlock)
                        }
                    }
                }
        }
    }
    
    open func getObjects<Service:BaseClassesService, ResponseObject:BaseModel>(_ service:Service, successBlock:@escaping (([ResponseObject]) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        
        let request = Alamofire.request(service, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: self.authenticationHeaders())
        request.validate()
        request.responseArray(queue: nil, keyPath: service.rootKeyPath) { (response: DataResponse<[ResponseObject]>) -> Void in
            let mappedObject = response.result.value
            if mappedObject != nil {
                successBlock(mappedObject!)
                
            } else {
                request.responseArray { (response: DataResponse<[ResponseObject]>) -> Void in
                    let mappedObject = response.result.value
                    if mappedObject != nil {
                        successBlock(mappedObject!)
                    } else {
                        self.handleErrorResponse(response.data, refreshCompletionBlock: { () in
                            self.getObjects(service, successBlock: successBlock, errorBlock: errorBlock)
                        }, errorBlock: errorBlock)
                        
                    }
                }
            }
        }
    }
    
    fileprivate func handleErrorResponse(_ responseData:Data?, refreshCompletionBlock:@escaping ((Void) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        if self.sessionRefreshRequired(responseData) {
            let user = User.persistentUserObject()
            let refreshObject = RefreshUser()
            refreshObject.refreshToken = user.refreshToken
            AuthenticationService().refreshUser(refreshObject, withSuccessBlock: { (user) in
                user.save()
                refreshCompletionBlock()
            }, andError: { (error) in
                    errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An error has occured, please try again later"]))
            })
        } else {
            errorBlock(NSError(domain: self.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An error has occured, please try again later"]))
        }
    }
    
    fileprivate func authenticationHeaders() -> [String: String] {
        var httpHeaders = [String: String]()
        
        let userSessionToken = User.persistentUserObject().idToken as String
        httpHeaders["Authorization"] = userSessionToken
        
        if let AWSAPIKey = Bundle.main.infoDictionary?["AWSAPIKey"] as? String {
            httpHeaders["x-api-key"] = AWSAPIKey
        } else {
            assertionFailure("Provide a AWS API Key in the info PLIST file")
        }
        
        return httpHeaders
    }
    
    fileprivate func checkForErrorInObject(_ object:BaseModel) -> NSError? {
        return NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong, please try again"])
    }
    
    fileprivate func sessionRefreshRequired(_ data:Data?) -> Bool {
        if let updatedData = data {
            if let object = try? JSONSerialization.jsonObject(with: updatedData, options: []) {
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
