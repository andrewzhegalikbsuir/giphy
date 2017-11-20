//
//  StorageOfGifs.swift
//  GiphyTestApp
//
//  Created by Monya on 11/20/17.
//  Copyright © 2017 ZhegalikInc. All rights reserved.
//

import SwiftyJSON

class GifStorage {
    
    var gifObjects = [GifObject]()
    
    private(set) var isBusy = false
    
    private let limit: Int = 25
    private var offset: Int = 0
    
    private var _query: String = ""
    
    var query: String {
        set {
            self._query = newValue.replacingOccurrences(of: " ", with: "+")
        }
        
        get {
            return self._query
        }
    }
    
    private var rating: String = "pg"
    
    func loadGifs(_ isSearchRequest: Bool = false, completionHandler: @escaping ((_ success: Bool) -> Void)) {
        guard !isBusy else {
            completionHandler(false)
            return
        }
        
        self.isBusy = true
        
        DispatchQueue.global(qos: .background).async {
            guard let url = self.calculateURL(isSearchRequest) else {
                completionHandler(false)
                return
            }
            
            self.getGifDataAsJSON(url) { json in
                if let json = json {
                    self.gifObjects += self.parseJSONToGifObjectsArray(json)
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
                
                self.isBusy = false
            }
        }
        
    }
    
    private func getGifDataAsJSON(_ url: URL, completionHandler: @escaping ((JSON?)->())) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                return
            }
            
            if data != nil {
                self.offset += self.limit
                completionHandler(JSON(data as Any))
            }
        }
        task.resume()
    }
    
    private func parseJSONToGifObjectsArray(_ json: JSON) -> [GifObject] {
        
        var parsedGifObjects = [GifObject]()
        
        for counter in 0 ..< self.limit {
            var everTrended = false
            
            let everTrendedPath: [JSONSubscriptType] = ["data",counter, "trending_datetime"]
            let urlPath: [JSONSubscriptType] = ["data", counter, "images", "fixed_width", "url"]
            
            if let everTrendedJSON = json[everTrendedPath].string {
                if everTrendedJSON != "1970-01-01 00:00:00" {
                    if everTrendedJSON != "0000-00-00 00:00:00" {
                        everTrended = true
                    }
                }
                
            } else {
                print ("seems like everTrended parse had failed \n next iteration..")
                continue
            }
            
            if let url = json[urlPath].string {
                let justAnotherGifObject = GifObject(url, everTrended)
                
                parsedGifObjects.append(justAnotherGifObject)
                
            } else {
                print("seems like url parse had failed")
            }
        }
        return parsedGifObjects
    }
    
    
    private func calculateURL(_ isSearchRequest: Bool) -> URL? {
        if  !isSearchRequest {
            let parameters = [
                ParameterKeys.ApiKey: Constants.ApiKey,
                ParameterKeys.Limit: limit,
                ParameterKeys.Offset: offset
            ]
            
            //URL(string: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=\(limit)&offset=\(offset)")
            guard let url = URL(string: UrlMaker.getURLFromParameters(parameters, apiPath: (Constants.ApiPathGifs + Methods.Trending)))
                else {
                    return nil
            }
            return url
            
        } else {
            let parameters = [
                ParameterKeys.ApiKey: Constants.ApiKey,
                ParameterKeys.Limit: limit,
                ParameterKeys.Offset: offset,
                ParameterKeys.Rating: rating,
                ParameterKeys.Query: query
            ]
            
            //"http://api.giphy.com/v1/gifs/search?q=\(query)&api_key=dc6zaTOxFJmzC&limit=\(limit)&offset=\(offset)&rating=\(rating)"
            
            guard let url = URL(string: UrlMaker.getURLFromParameters(parameters, apiPath: (Constants.ApiPathGifs)))
                else {
                    return nil
            }
            return url
        }
    }
}

