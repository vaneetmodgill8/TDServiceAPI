//
//  File.swift
//  TDServiceAPI
//
//  Created by Yapapp on 07/11/17.
//

import Foundation

public enum MethodType {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum URLEncodingType{
    case FORM
    case QUERY
    case JSONENCODING
    case FileUpload
}

public struct WebServiceRequest{
    var selectedMethodType:MethodType = .GET
    var selectedURLEncodingType:URLEncodingType = .FORM
    var url:String = ""
    var parameters:[String:Any]?
    var headers:[String:String]?
    var timeOutSession = 60
}

public protocol WebServiceConfigurator{
    weak var dataSource: WebServiceAble? {set get}
    func initiateWebService()
}

struct WebServiceConfiguratorClient: WebServiceConfigurator{
    var dataSource: WebServiceAble?
    
    func initiateWebService(){
        let timeOut = self.dataSource?.requestTimeOut()
    }
}
public enum Result<T> {
    case Success(T)
    case Failure(Error)
}
public protocol WebServiceAPI{
    func call(_ request: WebServiceRequest,completionHandler: @escaping (Result<String>) -> Void )
}

public protocol WebServiceAble: class {
    
    // These should be called only by configurator to create webservice request
    var requestData: AnyObject? {get set}
    
    func webserviceIsBodyParameterRequired() -> Bool
    
    func webserviceBodyParameters(data:AnyObject?) -> [String:AnyObject]?
    
    func webserviceIsHeaderParameterRequired() -> Bool
    
    func webserviceHeaderParameters(data:AnyObject?) -> [String:AnyObject]?
    
    func webserviceAPI() -> String?
    
    func webServerHost() -> String?
    
    func webServiceIsAccessTokenRequired() -> Bool
    
    func requestTimeOut()->Int
    
    func webServiceAPIClient() -> WebServiceAPI
    
    func webServiceMethodType() -> MethodType
    
    func webServiceEncodingType() -> URLEncodingType
    
    // It should be called only by class / struct that need data
    func call(_ data: AnyObject?)
    
}

extension WebServiceAble{
    
    func webserviceIsBodyParameterRequired()->Bool{
        return false
    }
    
    func webserviceBodyParameters(data:AnyObject?)->[String:AnyObject]?{
        return nil
    }
    
    func webserviceIsHeaderParameterRequired()->Bool{
        return false
    }
    
    func webserviceHeaderParameters(data:AnyObject?)->[String:AnyObject]?{
        return nil
    }
    
    func webserviceAPI()->String?{
        return nil
    }
    
    func webServerHost()->String?{
        return nil
    }
    
    func webServiceIsAccessTokenRequired()->Bool{
        return false
    }
    
    func requestTimeOut()->Int{
        return 60
    }
    
    func webServiceAPIClient() -> WebServiceAPI{
        return WSApiAlamofire()
    }
    
    func webServiceMethodType()->MethodType{
        return .GET
    }
    
    func webServiceEncodingType()->URLEncodingType{
        return .QUERY
    }
    
    func call(_ data: AnyObject?){
        self.requestData = data
        var configurator = WebServiceConfiguratorClient()
        configurator.dataSource = self
        configurator.initiateWebService()
    }

}



class TestWebServiceManager: WebServiceAble{
    var requestData: AnyObject?
}

class TestServiceManager{
    var wsManager = TestWebServiceManager()
    
    func start(){
        let data = ["String":"Test"] as AnyObject
        wsManager.call(data)
    }
    
    
    
}
