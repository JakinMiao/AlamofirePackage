//
//  Network.swift
//  Swift-app
//
//  Created by Jakin on 2017/10/21.
//  Copyright © 2017年 Jakin. All rights reserved.
//

import Foundation

/** 这个是跟服务端商定好的状态码，可以自己添加，对应的状态给出自定义操作 */
enum ResponseFlag: Int {
    case ResponseFlagSuccess = 0
    case ResponseFlagFailure = 1
}

typealias SuccessCompletionHandler = (Int) -> Void;
typealias FailureCompletionHandler = (Int, String) -> Void;

class Network: BaseNetwork {
    func analystResponse() -> Void {
        print("数据请求成功");
        //通用的数据请求成功处理
    }
    func startCompletionHandler(successHandler: @escaping SuccessCompletionHandler, failureHandler: @escaping FailureCompletionHandler) -> Void {
        self.startCompletion({ (baseNetwork: BaseNetwork) -> Void in
            let responseObject = self.responseObject as! Dictionary<String, Any>;
            
            let flag = responseObject["code"] as! Int;
            if (flag == ResponseFlag.ResponseFlagSuccess.rawValue) {
                self.analystResponse();
                successHandler(flag);
            } else {
                let error = responseObject["msg"] as! String;
                failureHandler(flag, error);
            }
            
        },{(baseNetwork: BaseNetwork) -> Void in
            failureHandler(-1001, "网络不太对劲，请检查网络设置");
        })
    }
}
