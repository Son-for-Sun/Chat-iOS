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
    func exeRequest(router:RouterProtocol,completionHandler:@escaping (Response<Any, NSError>) -> Void) {
        Alamofire.request(router.requestURL, withMethod: router.method, parameters: router.requestParameters).responseJSON { (res) in
            completionHandler(res)
        }
    }
}
