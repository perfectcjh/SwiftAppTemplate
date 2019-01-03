//
//  HttpProviderPlugin.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/2.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import Moya
import Result

/// 添加token插件
struct AddTokenPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest{
        
        let token = "xxx"
        guard let authable = target as? AccessTokenAuthorizable, token.count > 0 else { return request }
        
        var request = request
        let type = authable.authorizationType
        switch type {
        case .basic, .bearer:
            let authValue = (type.value ?? "") + " " + token
            request.addValue(authValue, forHTTPHeaderField: "Authorization")
        default:
            break;
        }
        return request
    }
    
}

/// 添加请求公共参数插件
struct JoinVeriSignaturePlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        switch target.task {
        case .requestParameters(parameters: let parameter, encoding: let encoder):
            
            let newParameter = joinVeriSignature(parameter)
            
            if LoggerHttpRequset{
                print("\n Request parameters: \n  \(newParameter) \n" )
            }
            
            do{
                var newReuest = try encoder.encode(request, with: newParameter)
                newReuest.timeoutInterval = 20.0
                return newReuest
            }catch{
                assertionFailure("加入验证签名出错")
                return request
            }
        default:
            return request
        }
    }
    
    func joinVeriSignature(_ parameter: [String: Any] ) -> [String: Any]{
        var newPara : [String: Any] = [:]
        
        func getSignString(_ item : Any) -> String{
            
            if JSONSerialization.isValidJSONObject(item) {
                do{
                    let data = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                    return String.init(data: data, encoding: .utf8)!
                }catch{
                    return ""
                }
            }
            return "\(item)"
        }
        
        for (key, value) in parameter{
            newPara[key] = value
        }
        
        // --------------------- 基础数据加这里，千万不要写到sign后面 ------------------------
        newPara["timestamp"] = "xxx"
        newPara["os"] = "ios"
        newPara["version"] = CurrentServerVersion
        newPara["imei"] = ""
        newPara["osVersion"] = ""
        // ----------------------- end ----------------------
        
        let orderKeys = newPara.keys.sorted(by: <)
        var finalString = ""
        for key in orderKeys {
            finalString.append(key)
            finalString.append(getSignString(newPara[key]!))
        }
        finalString.append(ServerSignKey)
        
        newPara["sign"] = ""
        
        return newPara
    }
}

/// 用来校验服务器错误代码
struct CheckErrorCodePlugin: PluginType {
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        
//        switch result {
//        case .success(let response):
//            break
            // 检查token是否失效
            //            if let data = try? response.mapEmptyData(), let code = data?.code, code == LoginInfoInvalidCode {
            //                let account = try! ServiceLocator.resolve() as AccountMananger
            //                account.logout()
            //                if let msg = data?.message{
            //                    Toast.showError(msg)
            //                }
            //                print("检测到token失效, path = \(target.path)")
        //            }
//        default:
//            break
//        }
    }
}


