//
//  BaseNetwork.swift
//  Swift-app
//
//  Created by Jakin on 2017/10/21.
//  Copyright © 2017年 Jakin. All rights reserved.
//

import Foundation
import Alamofire

enum RequestMethod: Int {
    case RequestGet = 0
    case RequestPost = 1
    case RequestPatch = 2
    case RequestPut = 3
}

class BaseNetwork {
    
    typealias RequestCompletionBlock = (BaseNetwork) -> Void;
    
    var successCompletionBlock: RequestCompletionBlock?;
    var failureCompletionBlock: RequestCompletionBlock?;
    var dataRequest: DataRequest?;
    
    var responseObject : Any?;
    
    func requestUrl() -> String {
        return "";
    }
    func baseUrl() -> String {
        return "";
    }
    func requestTimeoutInterval() -> Double {
        return 15;
    }
    func requestMethod() -> RequestMethod {
        return .RequestGet;
    }
    func requestParams() -> Any? {
        return nil;
    }
    func start() -> Void {
        NetworkAgent.shareinstance.addRequest(request: self);
    }
    func startCompletion(_ successCompletionBlock: @escaping RequestCompletionBlock, _ failureCompletionBlock: @escaping RequestCompletionBlock) -> Void {
        self .setCompletionBlock(successCompletionBlock: successCompletionBlock, failureCompletionBlock: failureCompletionBlock);
        self.start();
    }
    func setCompletionBlock(successCompletionBlock: @escaping RequestCompletionBlock, failureCompletionBlock: @escaping RequestCompletionBlock) -> Void {
        self.successCompletionBlock = successCompletionBlock;
        self.failureCompletionBlock = failureCompletionBlock;
    }
}
