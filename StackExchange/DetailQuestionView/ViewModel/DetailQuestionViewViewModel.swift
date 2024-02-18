//
//  DetailQuestionViewViewModel.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/24/23.
//

import UIKit

class DetailQuestionViewViewModel {
    
    var dataManager: DetailQuestionDataManaging
    
    init(dataManager: DetailQuestionDataManaging ) {
        self.dataManager = dataManager
    }
    
    let urlString = "https://api.stackexchange.com/2.2/questions/56433665?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=30&filter=!9_bDDxJY5"
    
    func getURL(quetionID: Int) -> String {
        return "https://api.stackexchange.com/2.2/questions/\(quetionID)?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=30&filter=!9_bDDxJY5"
    }
    
    
    func questionListFetch(completion: @escaping(Result<DetailQuestion, Error>) -> Void) {
        dataManager.fetchDataAndParseJson(from: urlString) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                fatalError("Error while loading data")
            }
        }
    }
    
    func getProfileImage(from urlString: String,completion: @escaping (UIImage?,Error?)-> Void) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                
                // Check response status code
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let error = NSError(domain: "HTTPError", code: 0, userInfo: nil)
                    completion(nil, error)
                    return
                }
                
                // Ensure data is not empty
                guard let data = data else {
                    let error = NSError(domain: "NoDataError", code: 0, userInfo: nil)
                    completion(nil, error)
                    return
                }
                
                // Convert data to UIImage
                if let image = UIImage(data: data) {
                    completion(image, nil)
                } else {
                    let error = NSError(domain: "ImageConversionError", code: 0, userInfo: nil)
                    completion(nil, error)
                }
            }
        }
    }
}
