//
//  HttpTargetType.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/2.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import Moya

protocol HttpTargetType: TargetType, AccessTokenAuthorizable {
    
    /// 请求参数
    var parameters: [String : Any]? { get }
}

extension HttpTargetType {
    
    var baseURL: URL {
        return URL(string: AppServerBaseUrl)!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var authorizationType: AuthorizationType {
        return AuthorizationType.bearer
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var task: Task{
        return .requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding.default)
    }
}
