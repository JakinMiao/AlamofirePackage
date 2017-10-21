//
//  TestApi.swift
//  Swift-app
//
//  Created by Jakin on 2017/10/21.
//  Copyright © 2017年 Jakin. All rights reserved.
//

import Foundation

class TestApi: Network {
    override func requestUrl() -> String {
        return "/jakin/appInfo";
    }
    func getUserInfo(success: @escaping (Int)->Void) -> Void {
        self.startCompletionHandler(successHandler: { (flag) in
            
        }) { (flag, message) in
            
        }
    }
}
