//
//  TargetConfig.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/2.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import Foundation

/// 当前环境
let appEnv = AppEnv.release

let LoggerHttpRequset = true
let LogggerHtmlApi = true

enum AppEnv {
    case debug
    case test
    case release
}

var AppServerBaseUrl: String = {
    switch appEnv{
    case .debug:
        return DebugServerBaseUrl
    case .test:
        return TestServerBaseUrl
    case .release:
        return ReleaseServerBaseUrl
    }
}()

/// 服务器基地址
let VersionSuffix = "v1/"
let DebugServerBaseUrl = "http://test-capi.cgs18.com/" + VersionSuffix
let TestServerBaseUrl = "http://test-capi.cgs18.com/" + VersionSuffix
let ReleaseServerBaseUrl = "http://capi.cgs18.com/" + VersionSuffix

/// 当前服务器APP版本号
let CurrentServerVersion = "2.3.5"

/// 服务器签名串
let ServerSignKey: String = "c2ZBcGlpT1MyMDE3MDIyOA=="


let AppStoreAddress = "https://itunes.apple.com/cn/app/idxxx" // appstore下载地址
