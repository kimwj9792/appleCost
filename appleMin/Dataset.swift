//
//  Dataset.swift
//  appleMin
//
//  Created by 김우재 on 2021/05/10.
//

import Foundation

struct response: Codable {
    struct airpods: Codable {
        let imageURL: String
        let name: String
        let currentPrice: Int
        let highPrice: Int
        let lowPrice: Int
        let date: [String]
        let price: [Int]
    }
    struct chargers: Codable {
        let imageURL: String
        let name: String
        let currentPrice: Int
        let highPrice: Int
        let lowPrice: Int
        let date: [String]
        let price: [Int]
    }
    struct accessories: Codable {
        let imageURL: String
        let name: String
        let currentPrice: Int
        let highPrice: Int
        let lowPrice: Int
        let date: [String]
        let price: [Int]
    }
    let airpods: [airpods]
    let chargers: [chargers]
    let accessories: [accessories]

}
