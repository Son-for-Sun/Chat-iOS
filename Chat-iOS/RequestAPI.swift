//
//  RequestAPI.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import Alamofire

class RequestAPI {
    static let share = RequestAPI()
    private init(){}
    
    /// 执行网络请求
    ///
    /// - parameter router:            请求的路由
    /// - parameter completionHandler: 请求完成的回调闭包
    /// 这里需要注意的是回调闭包使用了关键字 @escaping 是因为 request 是一个异步执行的函数
    func exeRequest(router: RouterProtocol,completionHandler: @escaping (DataResponse<Data>) -> Void) -> Void {
        
      request(router.requestURL, method: router.method, parameters: router.requestParameters)
       .responseData { (dataresponse) in
           completionHandler(dataresponse)
        }
    }
}
