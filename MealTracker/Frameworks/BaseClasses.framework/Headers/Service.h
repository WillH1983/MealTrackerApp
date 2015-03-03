//
//  LifeService.h
//  Life
//
//  Created by William Hindenburg on 1/4/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@protocol Service <NSObject>
@optional

/**
 @brief This methoded is called to get the URL path.  This URL is appended to the base URL.
 @return The service URL that is to be called to retrieve the data
 @code - (NSString *)serviceURL {
    return @"/1/login";
 }
 */
- (NSString *)serviceURL;

/**
 @brief This methoded is called to retrieve the mapping of the response data
 @return The mapping that will be used to map the service response
 @code - (RKObjectMapping *)mappingProvider {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    [mapping addAttributeMappingsFromDictionary:@{@"sessionToken":@"sessionToken"}];
    [mapping addAttributeMappingsFromDictionary:@{@"username":@"username"}];
    [mapping addAttributeMappingsFromDictionary:@{@"pointsPerWeek":@"pointsPerWeek"}];
    return mapping;
 }
 */
- (RKObjectMapping *)mappingProvider;

/**
 @brief This methoded is called to retrieve the mapping of the data object that is being posted
 @return The mapping that will be used to map the object being posted
 @code - (RKObjectMapping *)serializedMappingProvider {
    RKObjectMapping *seriallMapping = [RKObjectMapping mappingForClass:[User class]];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"username":@"username"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"password":@"password"}];

    return seriallMapping;
 }
 */
- (RKObjectMapping *)serializedMappingProvider;

/**
 @brief This methoded is called to get base URL of the service.
 @return The base URL that is to be called to retrieve the data
 @code - (NSString *)baseURL {
     return @"https://api.parse.com";
 }
 */
- (NSString *)baseURL;

/**
 @brief This methoded is used to determine where the mapping of the response JSON starts.
 
 For example, consider the following JSON:
 
 { "users":
     {
     "blake": {  "id": 1234, "email": "blake@restkit.org" },
     "rachit": { "id": 5678, "email": "rachit@restkit.org" }
     }
 }
 
 In order to map the users, the rootKeyPath would be "users".
 
 @return The path where the mapping starts for the response data
 @code - (NSString *)rootKeyPath {
     return @"users";
 }
 */
- (NSString *)rootKeyPath;

/**
 @brief This method is used to determine where the mapping of the post Object starts in relation to the JSON.
 
 For example, consider the following JSON:
 
 { "users":
     {
     "blake": {  "id": 1234, "email": "blake@restkit.org" },
     "rachit": { "id": 5678, "email": "rachit@restkit.org" }
     }
 }
 
 In order to post the users, the rootRequestKeyPath would be "users".
 
 @return The base URL that is to be called to retrieve the data
 @code - (NSString *)rootRequestKeyPath {
     return @"users";
 }
 */
- (NSString *)rootRequestKeyPath;

/**
 @brief This method is used to determine where the mapping of the post Object starts in relation to the JSON.
 
 For example, consider this URL: https://api.parse.com/1/login?username=cooldude6&password=password123. The dictionary to return will look like this: @{@"username":@"cooldude6", @"password":@"password123"};
 
 @code - (NSDictionary *)parameters {
     return @{@"username":@"cooldude6", @"password":@"password123"};
 }
 
 @return The parameters to be encoded and appended as the query string for the request URL.
 */
- (NSDictionary *)parameters;
@end
