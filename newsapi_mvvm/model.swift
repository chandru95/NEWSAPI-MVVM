//
//  model.swift
//  newsapi_mvvm
//
//  Created by Karthiga on 10/13/23.
//

import Foundation
struct ArticleS: Codable {
    var articles: [ArticleNew]?
}
    struct ArticleNew: Codable{
    var title : String?
    var description : String?
    var urlToImage: String?
    var url : String?
    var publishedAt: String?
    }
