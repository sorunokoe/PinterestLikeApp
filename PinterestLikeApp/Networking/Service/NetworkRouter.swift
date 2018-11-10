//
//  NetworkRouter.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class{
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
