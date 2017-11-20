//
//  UrlMaker.swift
//  GiphyTestApp
//
//  Created by Monya on 11/20/17.
//  Copyright © 2017 ZhegalikInc. All rights reserved.
//

import Foundation

class UrlMaker {
    
    class func getURLFromParameters(_ parameters: [String:AnyObject], apiPath: String, withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = apiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}
