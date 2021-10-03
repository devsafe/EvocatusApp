//
//  APIService.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import Foundation

class APIService {

    static let authenticatedEmployeeId = 7

    static func getEmployee() {
        let url = URL(string: "api.legion-hack.ru/employee/7/")!
        URLSession.shared
            .dataTask(with: url) { data, response, error in

            }.resume()
    }

    static func requestEvents(completion: @escaping (Result<Message, Error>) -> Void) {
        URLSession
            .shared
            .dataTask(with: URL(string: "https://api.legion-hack.ru/employee/\(String(authenticatedEmployeeId))/e-tinder/")!)
        { data, response, error in
            if let _ = error {
                completion(.failure(APIError.internalError))
                return
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(TopLevel.self, from: data)
                    completion(.success(result.message))
                } catch (let error) {
                    completion(.failure(error))
                }
                return
            }
            completion(.failure(APIError.internalError))
        }.resume()
    }

    static func likeEvent(employee: Int, activityId: Int, completion: @escaping (Error?) -> Void) {
        let url = URL(string: "https://api.legion-hack.ru/e-tinder/like/")!

        let parameterDictionary: [String: Any] = [
            "activity": activityId,
            "employee": employee
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameterDictionary, options: [])

        URLSession
            .shared
            .dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(APIError.internalError)
                } else {
                    completion(nil)
                }
            }.resume()
    }

    static func deleteMyEvent(employee: String, activityId: String, completion: @escaping (Error?) -> Void) {
        let url = URL(string: "https://api.legion-hack.ru/employee/\(employee)/e-tinder/\(activityId)/delete/")!

        let parameterDictionary: [String: Any] = [:]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameterDictionary, options: [])

        URLSession
            .shared
            .dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(APIError.internalError)
                } else {
                    completion(nil)
                }
            }.resume()
    }

    static func createEvent(
        employee: Int,
        name: String,
        category: String,
        imageUrl: String,
        place: String,
        dateIso: String,
        completion: @escaping (Error?) -> Void
    ) {
        let url = URL(string: "https://api.legion-hack.ru/e-tinder/")!

        let parameterDictionary: [String: Any] = [
            "creator": employee,
            "name": name,
            "category": category,
            "photo_url": imageUrl,
            "place": place,
            "dttm": dateIso
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameterDictionary, options: [])

        URLSession
            .shared
            .dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(APIError.internalError)
                } else {
                    completion(nil)
                }
            }.resume()
    }

    private struct TopLevel: Decodable {
        let success: Bool
        let message: Message
    }

    struct Message: Decodable {
        let employee: [Event]
        let other: [Event]
    }

    enum APIError: Error {
        case internalError
    }
}
