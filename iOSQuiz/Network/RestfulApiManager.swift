//
//  RestfulApiManager.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import Foundation
import Alamofire
import AlamofireImage

enum NetworkResult {
    case success(Data)
    case failure(String)
}

public class RestfulApiManager {
    public static let shared = RestfulApiManager()
    
    private let session: Session = Session(configuration: URLSessionConfiguration.default)
    
    private let queue = DispatchQueue(label: "com.Luke.RestfulApi", attributes: .concurrent)
    
    func requestApiData(_ params: RestfulApiParameters,  completion: @escaping (NetworkResult)->()) {
        let url: URLConvertible = params.url
        let method: HTTPMethod = params.method.method
        let parameters: Alamofire.Parameters? = params.parameters
        let encoding = params.encoding.encoding
        let headers = HTTPHeaders(params.headers)
        self.session.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData(queue: self.queue) { response in
            switch response.result {
            case .success(let data):
                completion(NetworkResult.success(data))
                
            case .failure(let error):
                completion(NetworkResult.failure(error.errorDescription ?? "NetworkError"))
            }
        }
    }
}
