//
//  PinterestEndPoint.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case production
}

public enum PinterestApi {
    case all(page: Int)
}

extension PinterestApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://pastebin.com/raw/wgkJgazE"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .all(let page):
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .all(let page):
//            return .requestParameters(bodyParameters: nil,
//                                      urlParameters: ["page":page])
            return .request
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
