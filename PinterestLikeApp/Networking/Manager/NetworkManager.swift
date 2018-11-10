//
//  NetworkManager.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation

enum NetworkResponse: String{
    case success
    case authenticationError = "You needed to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
enum Result<String>{
    case success
    case failure(String)
}
struct NetworkManager{
    
    static let environment: NetworkEnvironment = .production
    private let router = Router<PinterestApi>()
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getNewImages(page: Int, completion: @escaping (_ images: [Image]?, _ error: String?) -> Void){
        router.request(.all(page: page)) { (data, response, error) in
            if error != nil{
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse{
                let result = self.handleNetworkResponse(response)
                switch result{
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do{
                        let apiResponse = try JSONDecoder().decode(ImageApiResponse.self, from: responseData)
                        completion(apiResponse.images, nil)
                    }catch{
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}

