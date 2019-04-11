//
//  APIManager.swift
//  WhiteHousePetitions
//
//  Created by Apo on 4/10/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation

class APIManager {
    
    class func getPetitions(url: String, completionHandler: @escaping (_:Petitions?, _:Error?) -> Void) {
        downLoad(url: url) { (data, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                 let decodedValue = try decoder.decode(Petitions.self, from: data)
                 completionHandler(decodedValue, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    class private func downLoad(url: String, completion: @escaping (_:Data?, _:Error?) -> Void) {
        guard let privateURL = URL(string: url) else { completion(nil, nil); return }
        let urlRequest = URLRequest(url: privateURL)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard data != nil else {
                completion(data, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
}
