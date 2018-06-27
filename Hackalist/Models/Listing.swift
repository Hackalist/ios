//
//  Listing.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/22/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//



import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let listing = try Listing(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.listingTask(with: url) { listing, response, error in
//     if let listing = listing {
//       ...
//     }
//   }
//   task.resume()

struct Listing: Codable {
    
    let months: [Hackaton]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let monthData = try container.decode([String:[Hackaton]].self)
        months = monthData[monthData.keys.first!]!
    }
    
}


struct Hackaton: Codable {
    let title: String
    let url: String
    let startDate: String
    let endDate: String
    let year: String
    let city: String
    let host: String
    let length: String
    let size: String
    let travel: String
    let prize: String
    let highSchoolers: String
    let cost: String
    let facebookURL: String
    let twitterURL: String
    let googlePlusURL: String
    let notes: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "url"
        case startDate = "startDate"
        case endDate = "endDate"
        case year = "year"
        case city = "city"
        case host = "host"
        case length = "length"
        case size = "size"
        case travel = "travel"
        case prize = "prize"
        case highSchoolers = "highSchoolers"
        case cost = "cost"
        case facebookURL = "facebookURL"
        case twitterURL = "twitterURL"
        case googlePlusURL = "googlePlusURL"
        case notes = "notes"
    }
}




/*
// MARK: Convenience initializers

extension Listing {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Listing.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Month {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Month.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func listingTask(with url: URL, completionHandler: @escaping (Listing?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

*/



//MARK: Saving data to the disk. This data is not sensitive.
extension Hackaton {
    

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("hackaton").appendingPathExtension("plist")
    
    
    static func saveToFile(list: [Hackaton]) {
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedHackaton = try? propertyListEncoder.encode(list)
        try? encodedHackaton?.write(to: Hackaton.archiveURL, options: .noFileProtection)
    }
    
    
    static func loadFromFile() -> [Hackaton]? {
        
        guard let codedHackatons = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<Hackaton>.self, from: codedHackatons)
    }
}






