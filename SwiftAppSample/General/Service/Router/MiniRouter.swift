//
//  MiniRouter.swift
//  Pods
//
//  Created by 周凌宇 on 2017/5/1.
//
//

import Foundation

public enum RouterError: Int {
    case RouteInvalid
    case Route404
    case URLInvalid
    case URL404
    case Unmatch
    
    public static let domain = "MiniRouterErrorDomain"
    
    func error() -> NSError {
        switch self {
        case .RouteInvalid:
            return self.error(info: "Route illegal")
        case .Route404:
            return self.error(info: "Route is illegal or not registration")
        case .URLInvalid:
            return self.error(info: "url invalid")
        case .URL404:
            return self.error(info: "can not open")
        case .Unmatch:
            return self.error(info: "No match for the results")
        }
    }
    
    /// 给定 userInfo 生成 NSError
    func error(info: String) -> NSError {
        let error: NSError = NSError(domain:RouterError.domain,
                                     code: self.rawValue,
                                     userInfo: [NSLocalizedDescriptionKey : info])
        return error
    }
}

public class MiniRouter {
    public typealias CompletionHandler = (NSError?) -> ()
    public typealias RouteHanlder = (MiniURL) -> Void
    
    static let syncQueue: DispatchQueue = DispatchQueue(label: "com.zhoulingyu.Mini.syncQueue", attributes: .concurrent)
    public static let sharedInstance = MiniRouter()
    public var error: NSError?
    

    private var routeMap: [String : RouteHanlder] = [String : RouteHanlder]()
    
    /// 获取所有注册路由
    public var allRoutes: [String] {
        get{
            return Array(routeMap.keys)
        }
    }
    

   @discardableResult  public func register(route: String, handler: @escaping RouteHanlder ) -> NSError? {
        return add(route: route, handler: handler)
    }
    

    public func deregister(route: String) {
        return remove(route: route)
    }
    
    /// 打开 url，该方法尽量用于 H5 的跳转，要尽量避免在 open url 时让 url 带有过多参数
    ///
    /// - Parameter url: url string，可以带参数，
    /// - Returns: MiniRouter 实例
    @discardableResult public  func open(url: String)  -> MiniRouter {
        let router = MiniRouter()
        guard !url.isEmpty else {
            router.error = RouterError.URLInvalid.error()
            return router
        }
        
        guard let MiniURL = MiniURL(url: url) else {
            router.error = RouterError.Route404.error()
            return router
        }
        guard let param = MiniURL.params as? Dictionary<String, String> else {
            return open(route: MiniURL.route, params: nil, originalUrl: url)
            
        }
        return open(route: MiniURL.route, params: param, originalUrl: url)
    }
    
    /// open url
    /// 建议用该方法
    ///
    /// - Parameters:
    ///   - route: 路由模板
    ///   - params: 参数字典
    /// - Returns: MiniRouter 实例
    @discardableResult
    public func open(route: String, params: [String : Any]?, originalUrl: String? = nil) -> MiniRouter {
        
        
        let originalUrl = originalUrl ?? route
       
        
        let router = MiniRouter()
        // 通过 url 找到对应 route
        // 防止外部传入 route 有多余字符如 ?param=xxx
        guard let route = MiniURL.route(url: route) else {
            router.error = RouterError.Route404.error()
            return router
        }
        
        // 这个地方写的烂，有心的修改一下吧, 临时用一下
        let url = URL(string: route)!
        let scheme = (url.scheme ?? "") + ":"
    
        var hanlder: RouteHanlder!
        
        // 通过 route 找到对应 handler
        if let normalHanlder = routeMap[route] {
            hanlder = normalHanlder
        } else if let schemeHanlder = routeMap[scheme] {
            hanlder = schemeHanlder
        }else{
            router.error = RouterError.Route404.error()
            return router
        }
        
        guard let MiniURL = MiniURL(route: route, url: originalUrl) else {
            router.error = RouterError.Unmatch.error()
            return router
        }
        
        if params == nil {
            hanlder(MiniURL)
            return router
        }
        
        MiniURL.params = Dictionary()
        
        for (key, value) in params! {
            MiniURL.params![key] = value
        }
        
        hanlder(MiniURL)
        return router
    }
    
    public func completion(_ completion: @escaping CompletionHandler) {
        completion(error)
    }
    
    // MARK: - Private
    
    private func add(route: String, handler: @escaping (MiniURL) -> ()) -> NSError? {
        // 提纯操作，确保传入者没有传入 多余的 query 或者 /
        guard let route = MiniURL.route(url: route) else {
            return RouterError.RouteInvalid.error()
        }
        guard URL(string: route) != nil else {
            return RouterError.RouteInvalid.error()
        }
        _ = MiniRouter.syncQueue.sync { [weak self] in
            self?.routeMap.updateValue(handler, forKey: route)
        }
        return nil
    }
    
    private func remove(route: String) {
        _ = MiniRouter.syncQueue.sync { [weak self] in
            self?.routeMap.removeValue(forKey: route)
        }
    }
    
}
