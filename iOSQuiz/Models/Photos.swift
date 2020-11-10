//
//  Photos.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import Foundation

struct Photos: Decodable {
    let albumId, id: Int?
    let title, url, thumbnailUrl: String?
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try keyedContainer.decodeIfPresent(Int.self, forKey: .albumId)
        id = try keyedContainer.decodeIfPresent(Int.self, forKey: .id)
        title =  try keyedContainer.decodeIfPresent(String.self, forKey: .title)
        url =  try keyedContainer.decodeIfPresent(String.self, forKey: .url)
        thumbnailUrl =  try keyedContainer.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
