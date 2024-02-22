//
//  ViewController.swift
//  APIrequest
//
//  Created by Jibryll Brinkley on 2/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://swapi.dev/api/" + "films/"
        fetchData(from: url)
    }
    
    private func fetchData(from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            //have data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print(String(describing: error))
            }
            
            guard let json = result else {
                return
            }
            print(json.results)
            
        })
            
            task.resume()
        
    }
}

    
// Tasks
// 1. Need a URL to get data from - SWAPI API to retrieve Star Wars data
// 2. Need a struct or a class to map data to once we get it from url
// 3. Need to dispay the data to the user 

struct Response: Codable {
    let count: Int
    let results: [MyResult]
}

struct MyResult: Codable {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
}
