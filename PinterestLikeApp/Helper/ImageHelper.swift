//
//  ImageDownloader.swift
//  PinterestLikeApp
//
//  Created by Mac on 10.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit
import Kingfisher


enum ImageHelperSizeType{
    case full, raw, small, regular, thumb
}
class ImageHelper{
    static let shared = ImageHelper()
    init() {
        ImageCache.default.maxDiskCacheSize = 50 * 1024 * 1024
    }
    func setImage(image: Image, size: ImageHelperSizeType, completion: @escaping (UIImage) -> ()){
        guard let imageURL = getUrlBy(image: image, size: size) else { return }
        getImageFromCache(url: imageURL) { (image) in
            if let image = image{
                completion(image)
            }else{
                self.downloadImage(url: imageURL, completion: { (image) in
                    if let image = image{
                        completion(image)
                    }
                })
            }
        }
    }
    func setImageBy(url: URL, completion: @escaping (UIImage) -> ()){
        getImageFromCache(url: url) { (image) in
            if let image = image{
                completion(image)
            }else{
                self.downloadImage(url: url, completion: { (image) in
                    if let image = image{
                        completion(image)
                    }
                })
            }
        }
    }
    func isImageExist(image: Image, size: ImageHelperSizeType, completion: @escaping (Bool) -> Void){
        guard let imageURL = getUrlBy(image: image, size: size) else { return }
        getImageFromCache(url: imageURL) { (image) in
            if image != nil{
                completion(true)
            }else{
                self.downloadImage(url: imageURL, completion: { (image) in
                    if image != nil{
                        completion(true)
                    }else{
                        completion(false)
                    }
                })
            }
        }
    }
    func clear(){
        ImageCache.default.clearMemoryCache()
    }
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void){
        ImageDownloader.default.downloadImage(with: url, options: [], progressBlock: nil) {
            (image, error, url, data) in
            if let image = image, let url = url{
                ImageCache.default.store(image,
                                             forKey: url.absoluteString,
                                             toDisk: false)
                completion(image)
            }else{
                completion(nil)
            }
        }
    }
    func getImageFromCache(url: URL, completion: @escaping (UIImage?) -> Void){
        ImageCache.default.retrieveImage(forKey: url.absoluteString, options: [.cacheMemoryOnly, .onlyFromCache]) {
            image, cacheType in
            if let image = image {
                completion(image)
            }else{
                completion(nil)
            }
        }
    }
    func cancelAllDownloads(){
        ImageDownloader.default.cancelAll()
    }
    private func getUrlBy(image: Image, size: ImageHelperSizeType) -> URL?{
        switch size {
        case .full:
            return URL(string: image.urls.full)
        case .raw:
            return URL(string: image.urls.raw)
        case .small:
            return URL(string: image.urls.small)
        case .regular:
            return URL(string: image.urls.regular)
        case .thumb:
            return URL(string: image.urls.thumb)
        }
    }
}
