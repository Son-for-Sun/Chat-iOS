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
    func exeRequest(router: RouterProtocol,completionHandler: @escaping (DataResponse<Any>) -> Void) -> Void {
        request(router.requestURL, method: router.method, parameters: router.requestParameters).responseJSON { (dataresponse) in
            completionHandler(dataresponse)
        }
    }
}
