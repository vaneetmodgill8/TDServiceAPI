//
//  WebService.swift
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

public protocol ApiResource {
    var url: String { get }
    func call()
}

public protocol RestApiResource: ApiResource {
    var methodType: MethodType { get }
    var urlEncodingType: URLEncodingType { get }
    var headerFields: [String: String]? { get }
    var parameters: [String: Any]? {get}
    var timeOut: Int { get }
}

extension RestApiResource{
    public var methodType: MethodType{ return .GET }
    public var urlEncodingType: URLEncodingType{ return .FORM }
    public var headerFields: [String: String]?{ return nil}
    public var parameters: [String: Any]? { return nil }
    public var timeOut: Int { return 60 }
    
    public func call() {
        print("Called Rest API Resource")
        print("\(String(describing: parameters))")
    }
}

struct Login{
    
}

class Abc{
    
}

