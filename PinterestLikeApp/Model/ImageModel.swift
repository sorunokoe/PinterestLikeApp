//
//  PinterestModel.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation

struct ImageApiResponse {
    let images: [Image]
}
extension ImageApiResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        images = try container.decode([Image].self)
    }
}
struct Image {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let likes: Int
    let liked_by_user: Bool
    let user: User
    let urls: ImageUrls
    let categories: [ImageCategory]
}
extension Image: Decodable {
    enum ImageCodingKeys: String, CodingKey {
        case id
        case created_at
        case width
        case height
        case color
        case likes
        case liked_by_user
        case user
        case urls
        case categories
    }
    init(from decoder: Decoder) throws {
        let imageContainer = try decoder.container(keyedBy: ImageCodingKeys.self)
        id = try imageContainer.decode(String.self, forKey: .id)
        created_at = try imageContainer.decode(String.self, forKey: .created_at)
        width = try imageContainer.decode(Int.self, forKey: .width)
        height = try imageContainer.decode(Int.self, forKey: .height)
        color = try imageContainer.decode(String.self, forKey: .id)
        likes = try imageContainer.decode(Int.self, forKey: .likes)
        liked_by_user = try imageContainer.decode(Bool.self, forKey: .liked_by_user)
        user = try imageContainer.decode(User.self, forKey: .user)
        urls = try imageContainer.decode(ImageUrls.self, forKey: .urls)
        categories = try imageContainer.decode([ImageCategory].self, forKey: .categories)
        
    }
}


struct User {
    let id: String
    let username: String
    let name: String
    let profile_image: ProfileImage
}
extension User: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profile_image
    }
    
    init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)
        id = try userContainer.decode(String.self, forKey: .id)
        username = try userContainer.decode(String.self, forKey: .username)
        name = try userContainer.decode(String.self, forKey: .name)
        profile_image = try userContainer.decode(ProfileImage.self, forKey: .profile_image)
    }
}

struct ProfileImage {
    let small: String
    let medium: String
    let large: String
}
extension ProfileImage: Decodable {
    enum ProfileImageCodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
    
    init(from decoder: Decoder) throws {
        let profileImageContainer = try decoder.container(keyedBy: ProfileImageCodingKeys.self)
        small = try profileImageContainer.decode(String.self, forKey: .small)
        medium = try profileImageContainer.decode(String.self, forKey: .medium)
        large = try profileImageContainer.decode(String.self, forKey: .large)
    }
}

struct ImageUrls {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
extension ImageUrls: Decodable {
    enum ImageUrlsCodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    init(from decoder: Decoder) throws {
        let imageUrlsContainer = try decoder.container(keyedBy: ImageUrlsCodingKeys.self)
        
        raw = try imageUrlsContainer.decode(String.self, forKey: .raw)
        full = try imageUrlsContainer.decode(String.self, forKey: .full)
        regular = try imageUrlsContainer.decode(String.self, forKey: .regular)
        small = try imageUrlsContainer.decode(String.self, forKey: .small)
        thumb = try imageUrlsContainer.decode(String.self, forKey: .thumb)
    }
}
struct ImageCategory {
    let id: Int
    let title: String
    let photo_count: Int
}
extension ImageCategory: Decodable {
    enum ImageCategoryCodingKeys: String, CodingKey {
        case id
        case title
        case photo_count
    }
    init(from decoder: Decoder) throws {
        let imageCategoryContainer = try decoder.container(keyedBy: ImageCategoryCodingKeys.self)
        id = try imageCategoryContainer.decode(Int.self, forKey: .id)
        title = try imageCategoryContainer.decode(String.self, forKey: .title)
        photo_count = try imageCategoryContainer.decode(Int.self, forKey: .photo_count)
    }
}


