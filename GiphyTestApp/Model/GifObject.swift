//
//  GifObject.swift
//  GiphyTestApp
//
//  Created by Monya on 11/20/17.
//  Copyright © 2017 ZhegalikInc. All rights reserved.
//

struct GifObject {
    var URL: String = ""
    var everTrended: Bool
    
    init(URL: String, everTrended: Bool) {
        self.URL = URL
        self.everTrended = everTrended
    }
}
