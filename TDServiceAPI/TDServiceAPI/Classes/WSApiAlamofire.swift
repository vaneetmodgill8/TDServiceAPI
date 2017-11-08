//
//  WebServiceApiAlamofire.swift
//  TDServiceAPI
//
//  Created by Yapapp on 07/11/17.
//

import Foundation
import Alamofire


struct WSApiAlamofire: WebServiceAPI{
    
    func call(_ request: WebServiceRequest,completionHandler:  @escaping (Result<String>) -> Void ){
        let url:String = request.url
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(request.timeOutSession)
        manager.request(url, method: self.getHTTPMethodType(type: request.selectedMethodType), parameters: request.parameters, encoding: self.getURLEncodingType(type: request.selectedURLEncodingType), headers:request.headers).response(completionHandler: { (response) in
            if response.error != nil{
                completionHandler(Result.Failure(response.error!))
                return
            }
            else{
                var description = ""
                if response.data != nil{
                    description = String(data: response.data!, encoding: .utf8)!
                }
                completionHandler(Result.Success(description))
                return
            }
        })
    }
    
    //MARK:- Private Method(s)
    private func getHTTPMethodType(type:MethodType) -> HTTPMethod{
        switch type {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
    
    private func getURLEncodingType(type:URLEncodingType) -> ParameterEncoding{
        switch type {
        case .FORM:
            return URLEncoding.httpBody
        case .QUERY:
            return URLEncoding.queryString
        case .JSONENCODING:
            return JSONEncoding.default
        default:
            return URLEncoding.httpBody
        }
        
    }
}


