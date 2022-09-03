//
//  Networking.swift
//  MonRestaurants
//
//  Created by s b on 29.04.2022.
//

import Foundation

class Networking {
    
    func fetchRandom(completion: @escaping (Result<fetchedRestaurants, Error>) -> Void) {
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
            "X-RapidAPI-Key": "787decd534mshf1f31e3e1ca675cp111035jsnf57ec89f6a36"
        ]
        
        let postData = NSMutableData(data: "location_id=15333482".data(using: String.Encoding.utf8)!)
        postData.append("&language=en_US".data(using: String.Encoding.utf8)!)
        postData.append("&currency=USD".data(using: String.Encoding.utf8)!)
        postData.append("&limit=10".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://worldwide-restaurants.p.rapidapi.com/photos")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(fetchedRestaurants(name: <#T##String#>, type: <#T##String#>, location: <#T##String#>, phone: <#T##String#>, summary: <#T##String#>, image: <#T##Data#>))
                    i = i + 1
            } else {
                complition(error)
            }
        })
        
        dataTask.resume()
    }
}
