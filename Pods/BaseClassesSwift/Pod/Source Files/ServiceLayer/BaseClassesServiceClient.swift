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
        let JSONString = Mapper().toJSON(object)
        let dictionary = [andService.rootRequestKeyPath:JSONString]
        let request = Alamofire.request(.POST, andService, parameters: dictionary, encoding: .JSON, headers: nil)
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
    
    private func checkForErrorInObject(object:BaseModel) -> NSError? {
        
        var error:NSError?
        
        switch object.errorType {
        case .ActivationKeyExpired:
            error = NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Your activation key has expired, please request a new one"])
        case .ActivationKeyIncorrect:
            error = NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Your activation key is incorrect, please try again"])
        case .ActivationKeyLocked:
            error = NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Your activation key has been locked from too many access attempts, please request a new one"])
        case .UserInputInvalid:
            error = NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Your email or activation code is incorrect, please try again"])
        case .GenericError:
            error = NSError(domain: errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong, please try again"])
        case .NoError:
            error = nil
        }
        return error
        
    }
}
