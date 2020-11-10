//
//  RestfulApiParameters.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import Foundation
import Alamofire

public struct RestfulApiParameters: CustomStringConvertible {
    public typealias HTTPHeaders = [String : String]
    public typealias Parameters = [String : Any]
    
    public let url: URL
    public var method: HTTPMethod
    public var encoding: ParameterEncoding
    public var headers: HTTPHeaders = [:]
    public var parameters: Parameters?
    
    public init(_ url: URL, method: HTTPMethod = .get, encoding: ParameterEncoding = .url, headers: HTTPHeaders = [:], parameters: Parameters? = nil) {
        self.url = url
        self.method = method
        self.encoding = encoding
        self.headers = headers
        self.parameters = parameters
        
        if self.headers["accept"] == nil {
            self.headers["accept"] = "application/json"
        }
        
        if self.headers["Content-Type"] == nil {
            self.headers["Content-Type"] = "application/json-patch+json"
        }
        
    }
    
    public var description: String {
        return "\nurl: \(url)\nmethod: \(method)\nencoding: \(encoding)\nheaders: \(headers)\nparameters: \(parameters ?? [:])"
    }
}

extension RestfulApiParameters {
    public enum HTTPMethod {
        case get
        case post
        case put
        case patch
        case delete
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .get:      return .get
            case .post:     return .post
            case .put:      return .put
            case .patch:    return .patch
            case .delete:   return .delete
            }
        }
    }
}

extension RestfulApiParameters {
    public enum ParameterEncoding {
        case url
        case json
        case array([Parameters])
        
        var encoding: Alamofire.ParameterEncoding {
            switch self {
            case .url:
                return URLEncoding.default
                
            case .json:
                return JSONEncoding.default
                
            case .array(let params):
                return JSONArrayEncoding(array: params)
            }
        }
    }
}

extension RestfulApiParameters {
    struct JSONArrayEncoding: Alamofire.ParameterEncoding {
        private let array: [Parameters]
        
        init(array: [Parameters]) {
            self.array = array
        }
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
            return urlRequest
        }
    }
}
