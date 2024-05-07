//
//  UniversityList.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation
import RealmSwift

class UniversityList: Object, Codable {
    
    @objc dynamic var stateProvince: String?
    var domains = List<String>()
    var webPages = List<String>()
    @objc dynamic var name: String?
    @objc dynamic var alphaTwoCode: String?
    @objc dynamic var country: String?

    private enum CodingKeys: String, CodingKey {
        case stateProvince = "state-province"
        case domains
        case webPages = "web_pages"
        case name
        case alphaTwoCode = "alpha_two_code"
        case country
    }
}


struct UniversityListResponse: Codable {
    let items: [UniversityList]
}
