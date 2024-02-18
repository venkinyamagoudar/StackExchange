//
//  DetailQuestionDataManager.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/24/23.
//


import UIKit

protocol DetailQuestionDataManaging {
    func fetchDataAndParseJson(from urlString: String, completion: @escaping(Result<DetailQuestion, Error>) -> Void)
}

class DetailQuetoinDataManager: DetailQuestionDataManaging {
    
    func fetchDataAndParseJson(from urlString: String, completion: @escaping(Result<DetailQuestion, Error>) -> Void) {
        extractJsonData(from: urlString) {[weak self] result in
            switch result {
            case .success(let data):
                self?.parseJsonData(jsonData: data) { result in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Description: Function used to extract data from from URL
    /// - Parameters:
    ///   - urlString: Desired URL in string format
    ///   - completion: Completion handler that handels the operation is success or failure
    func extractJsonData(from urlString: String, completion: @escaping(Result<Data,Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    //call parseJsonData
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    /// Description: Function used to get the data according to the DailyPredictoion Model.
    /// - Parameters:
    ///   - jsonData: The jsondata that is extracted from the URL
    ///   - completion: completion handler that handels the operation is success or failure
    func parseJsonData(jsonData: Data, completion: @escaping(Result<DetailQuestion,Error>) -> Void) {
        do{
            let decodedData = try JSONDecoder().decode(DetailQuestion.self, from: jsonData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
