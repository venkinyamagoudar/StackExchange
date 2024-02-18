//
//  QuestionsListViewModel.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

class QuestionsListViewModel {
    
    let dataManger: QuestionListDataManaging
    let urlString: String
    var questionList: QuestionList?
    
    init(dataManger: QuestionListDataManaging) {
        self.dataManger = dataManger
        self.urlString = "https://api.stackexchange.com/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=30"
    }
    
    func questionListFetch(completion: @escaping(Result<QuestionList, Error>) -> Void) {
        dataManger.getQuestionList(from: self.urlString) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                fatalError("Error while fetching Question List")
            }
        }
    }
}
