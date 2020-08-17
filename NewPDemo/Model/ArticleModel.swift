//
//  ArticleModel.swift
//  NewPDemo
//
//  Created by mehul modhvadiya on 17/08/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import Foundation

struct ArticleDataModel:Codable {
    var kind: String
    var data:dictArticle
}
struct dictArticle:Codable{
   var modhash: String
   var dist : Int
   var children : [articleChildren]
}
struct articleChildren :Codable{
    var kind : String
    var data : dictChildren
}
struct dictChildren :Codable{
    var selftext: String
    var author_fullname : String
    var title : String
    var thumbnail: String
    var url: String
    
    init(url:String,title:String,thumbnail:String,selftext:String,author_fullname:String) {
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.selftext = selftext
        self.author_fullname = author_fullname
    }
}
