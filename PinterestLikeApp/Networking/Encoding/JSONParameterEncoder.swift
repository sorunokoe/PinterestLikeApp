//
//  JSONParameterEncoder.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder{
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do{
            let jsonasData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonasData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil{
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch{
            throw NetworkError.encodingFailed
        }
        
    }
}
