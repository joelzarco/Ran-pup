//
//  DogAPI.swift
//  Ran-pup
//
//  Created by Johel Zarco on 08/04/22.
//

import Foundation

class DogAPI{
    
    static let stringUrl : String = "https://dog.ceo/api/breeds/image/random"
    
    class func parseDogUrl(url : String) -> URL{
        if let dogUrl = URL(string: url){
            return dogUrl
        } else{
            return URL(string: url)!
        }
    }
}
