//
//  HTTPTask.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//


public typealias HTTPHeaders = [String:String]
public enum HTTPTask{
    case request
    case requestParameters(bodyParameters: Parameters?,
        urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
    
    //download
}
