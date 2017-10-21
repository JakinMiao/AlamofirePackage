//
//  NetworkAgent.swift
//  Swift-app
//
//  Created by Jakin on 2017/10/21.
//  Copyright © 2017年 Jakin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkAgent {
    private var requestsRecord : Dictionary<String, Any>? = Dictionary<String, Any>();
    
    static let shareinstance = NetworkAgent()
    private init () {}
    
    func addRequest(request: BaseNetwork) -> Void {
        let url = self.buildRequestUrl(request: request);
        let params = request.requestParams();
        let headers: HTTPHeaders = [
            "os": "ios",
            "version": "1.0.0"
        ]
        let requestMethod: RequestMethod = request.requestMethod();
        var method: HTTPMethod = .get;
        
        switch requestMethod {
        case .RequestPost:
            method = .post
        case .RequestPatch:
            method = .patch
        case .RequestPut:
            method = .put
        default:
            method = .get
        }
        
        let manger = Alamofire.SessionManager.default;
        //设置超时时间, 默认 15s
        manger.session.configuration.timeoutIntervalForRequest = TimeInterval(request.requestTimeoutInterval());
        
        request.dataRequest = manger.request(url, method: method, parameters: params as! Parameters?, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print("\(String(describing: response.result.value))");
            self.handleResult(response: response, task: request.dataRequest?.task as! URLSessionDataTask);
        };
        self.addRequestTask(request: request);
    }
    
    func handleResult(response: DataResponse<Any>, task: URLSessionDataTask) -> Void {
        let key = self.requestHashKey(task: task);
        let request = requestsRecord![key] as? BaseNetwork;
        
        let data = response.result.value as? Dictionary<String, Any>;
        
        if (request != nil && data != nil) {
            //请求成功
            request?.responseObject = data;
            if ((request?.successCompletionBlock) != nil) {
                request?.successCompletionBlock!(request!);
            }
        } else {
            if ((request?.failureCompletionBlock) != nil) {
                request?.failureCompletionBlock!(request!);
            }
        }
        self.removeRequestTask(task: request?.dataRequest?.task as! URLSessionDataTask)
    }
    
    func buildRequestUrl(request: BaseNetwork) -> String {
        let apiUrl = request.requestUrl()
        
        if (apiUrl.hasPrefix("http")) {
            return apiUrl;
        }
        var baseUrl = "";
        
        if (request.baseUrl().characters.count > 0) {
            baseUrl = request.baseUrl()
        } else {
            baseUrl = "http://localhost:3009/api/v2"
        }
        return baseUrl.appending(apiUrl);
    }
    
    func addRequestTask(request: BaseNetwork) -> Void {
        if (request.dataRequest != nil) {
            let key = self .requestHashKey(task: request.dataRequest?.task as! URLSessionDataTask)
            objc_sync_enter(self);
            requestsRecord?.updateValue(request, forKey: key);
            objc_sync_exit(self);
        }
    }
    func removeRequestTask(task: URLSessionDataTask) -> Void {
        let key = self.requestHashKey(task: task);
        objc_sync_enter(self)
        requestsRecord?.removeValue(forKey: key);
        objc_sync_exit(self)
    }
    func requestHashKey(task: URLSessionDataTask) -> String {
        return String(task.hash);
    }
}
