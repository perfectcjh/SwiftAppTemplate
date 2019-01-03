//
//  HttpProvider.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/2.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import Moya

var default_requset_closure: MoyaProvider.RequestClosure = { endpoint, closure in
    do {
        let urlRequest = try endpoint.urlRequest()
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

class HttpProvider<Target: HttpTargetType>: MoyaProvider<Target>{
    
    /// 修改这个变量添加默认plugin
    private var defaultPlugins: [PluginType] = [
        JoinVeriSignaturePlugin(),
        AddTokenPlugin(),
        CheckErrorCodePlugin()
    ]
    
    
    override init(
        endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure: @escaping RequestClosure = default_requset_closure,
        stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
        callbackQueue: DispatchQueue? = nil,
        manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
        ) {
        
        if LoggerHttpRequset{
            defaultPlugins.append(NetworkLoggerPlugin(verbose: false))
        }
        
        super.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            manager: manager,
            plugins: defaultPlugins + plugins,
            trackInflights: trackInflights
        )
        
    }
}

