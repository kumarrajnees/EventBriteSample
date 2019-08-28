//
//  APIManager.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    var reqestList:NSMutableSet = NSMutableSet()
    var manager:SessionManager?
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        // setup code
        return instance
    }()
    
    
    class func request(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, success:@escaping (AnyObject) -> Void, failure:@escaping (HNError) -> Void){

        Alamofire.request(urlString, method : requestMethod, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                let errorStatusCode = response.response?.statusCode ?? 0
                let dnError = HNError()
                dnError.statusCode = errorStatusCode
                if dnError.statusCode == 0 {
                    debugPrint(response)
                }
                dnError.description = error.localizedDescription
                failure(dnError)
            }
        }
    }
    
    
    func stopAllPrevioudRequest() {
        for req in self.reqestList {
            (req as! DataRequest).suspend()
        }
        self.reqestList.removeAllObjects()
    }
    
    func stopRequest(url:URL) {
        var dataReq:DataRequest? = nil
        for req in self.reqestList {
            if (req as! DataRequest).request?.url == url {
                (req as! DataRequest).suspend()
                dataReq = (req as! DataRequest)
                break
            }
        }
        
        if let req = dataReq {
            self.reqestList.remove(req)
        }
    }
    
    
    class func requestRaw(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, success:@escaping (JSON) -> Void, failure:@escaping (HNError) -> Void){
        
        if APIManager.sharedInstance.manager == nil {
            APIManager.sharedInstance.createSessionManager()
        }
        
        let dataRequest =
            APIManager.sharedInstance.manager?.request(urlString, method : requestMethod, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
                
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    let errorStatusCode = response.response?.statusCode ?? 0
                    
                    if errorStatusCode == 200 {
                        success(json)
                    } else {
                        let dnError = HNError()
                        dnError.statusCode = errorStatusCode
                        dnError.description = json["error"].stringValue
                        failure(dnError)
                    }
                    
                    
                    
                case .failure(let error):
                    let errorStatusCode = response.response?.statusCode ?? 0
                    let dnError = HNError()
                    dnError.statusCode = errorStatusCode
                    if dnError.statusCode == 0 {
                        debugPrint(response)
                    }
                    dnError.description = error.localizedDescription
                    failure(dnError)
                }
        }
        
        
        if let request = dataRequest {
            APIManager.sharedInstance.reqestList.add(request)
        }
    }
    
    func createSessionManager() {
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            configuration.urlCache = nil
            return configuration
        }()
        
        configuration.timeoutIntervalForRequest = 60
        let serverTrustPolicies: [String: ServerTrustPolicy] = ["hackingwithswift.com": .disableEvaluation]
        manager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        manager?.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                //.AuthChallengeDispositionURLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)//URLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = self.manager?.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            
            return (disposition, credential)
        }
    }
}

class HNError {
    var statusCode : Int = 0
    var description : String = ""
}
