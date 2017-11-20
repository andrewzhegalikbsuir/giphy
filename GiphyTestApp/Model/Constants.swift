//
//  Constants.swift
//  GiphyTestApp
//
//  Created by Monya on 11/20/17.
//  Copyright © 2017 ZhegalikInc. All rights reserved.
//

import Foundation


struct Constants {
    
    // MARK: API Key
    static let ApiKey = "EiKUyrPceQakSEoEcEaDTe2glGNn7qcf"
    
    // MARK: URLs
    static let ApiScheme = "https"
    static let ApiHost = "api.giphy.com"
    static let ApiPathStickers = "/v1/stickers"
    static let ApiPathGifs = "/v1/gifs"
}

// MARK: Methods
struct Methods {
    
    // MARK: Search
   static let Search = "/search"
   static let Trending = "/trending"
    
}


// MARK: Parameter Keys
struct ParameterKeys {
    static let ApiKey = "api_key"
    static let Limit = "limit"
    static let Offset = "offset"
    static let Rating = "rating"
    static let Query = "q"
}



