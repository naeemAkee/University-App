//
//  APIRequest.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation
import RealmSwift

struct APIRequest {
    private static var baseUrl = "http://universities.hipolabs.com/"

    struct searchUAEUniversity: Request {
        var url: String {
            return baseUrl + "search?country=United%20Arab%20Emirates"
        }

        func params() -> [(key: String, value: String)] {
            return []
        }
    }

    func search(with request: searchUAEUniversity, onSuccess: @escaping ([UniversityList]) -> Void, onError: @escaping (Error) -> Void) {
        APICall().request(.get, request: request, onSuccess: { (data, session) in
            do {
                let response = try self.parse(data)
                DispatchQueue.main.async {
                    self.saveToRealm(response, onSuccess: onSuccess)
                }
            } catch {
                onError(APIError.failedParse)
            }
        }, onError: onError)
    }

    private func parse(_ data: Data) throws -> [UniversityList] {
        let response: [UniversityList] = try JSONDecoder().decode([UniversityList].self, from: data)
        return response
    }
    
    private func saveToRealm(_ items: [UniversityList], onSuccess: @escaping ([UniversityList]) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items)
            }
            DispatchQueue.main.async {
                onSuccess(items)
            }
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func fetchFromRealm(completion: @escaping ([UniversityList]?) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(UniversityList.self)
            let list = Array(results.filter { !$0.isInvalidated })
            completion(list)
        } catch {
            print("Error fetching data from Realm: \(error)")
            completion(nil)
        }
    }
}



//import Foundation
//import RealmSwift
//
//struct APIRequest {
//    private static var baseUrl = "http://universities.hipolabs.com/"
//
//    struct searchUAEUniversity: Request {
//        var url: String {
//            return baseUrl + "search?country=United%20Arab%20Emirates"
//        }
//
//        func params() -> [(key: String, value: String)] {
//            return []
//        }
//    }
//
//    func search(with request: searchUAEUniversity, onSuccess: @escaping ([UniversityList]) -> Void, onError: @escaping (Error) -> Void) {
//        APICall().request(.get, request: request, onSuccess: { (data, session) in
//            do {
//                let response = try self.parse(data)
//                DispatchQueue.main.async {
//                    self.saveToRealm(response, onSuccess: onSuccess)
//                }
//            } catch {
//                onError(APIError.failedParse)
//            }
//        }, onError: onError)
//    }
//
//    private func parse(_ data: Data) throws -> [UniversityList] {
//        let response: [UniversityList] = try JSONDecoder().decode([UniversityList].self, from: data)
//        return response
//    }
//    
//    private func saveToRealm(_ items: [UniversityList], onSuccess: @escaping ([UniversityList]) -> Void) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.delete(realm.objects(UniversityList.self))
//                realm.add(items)
//                DispatchQueue.main.async {
//                    onSuccess(items)
//                }
//            }
//        } catch {
//            print("Error saving data to Realm: \(error)")
//        }
//    }
//    
//    func fetchFromRealm(completion: @escaping ([UniversityList]?) -> Void) {
//        DispatchQueue.main.async {
//            do {
//                let realm = try Realm()
//                let results = realm.objects(UniversityList.self)
//                let list = Array(results)
//                completion(list)
//            } catch {
//                print("Error fetching data from Realm: \(error)")
//                completion(nil)
//            }
//        }
//    }
//
//
//}
