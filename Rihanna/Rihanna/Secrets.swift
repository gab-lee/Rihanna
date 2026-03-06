//
//  Secrets.swift
//  Rihanna
//
//  Created by Gabriel Lee on 6/3/26.
//

import Foundation

enum Secrets {

    static var weatherAPIKey: String {

        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["WEATHER_API_KEY"] as? String
        else {
            fatalError("Missing WEATHER_API_KEY in Config.plist")
        }

        return key
    }
}
