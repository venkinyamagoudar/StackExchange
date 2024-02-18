//
//  MockDataManager.swift
//  StackExchangeTests
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit
class MockDataManager: QuestionListDataManaging {
    
    func getQuestionList(from urlString: String, completion: @escaping (Result<QuestionList, Error>) -> Void) {
        let jsonString = """
        {
          "items": [
            {
              "tags": [
                "swift",
                "swiftui",
                "swift5"
              ],
              "owner": {
                "reputation": 4983,
                "user_id": 7282573,
                "user_type": "registered",
                "profile_image": "https://www.gravatar.com/avatar/636e5a5a698ebfa8894a4272ade4c1c7?s=256&d=identicon&r=PG&f=y&so-version=2",
                "display_name": "Half",
                "link": "https://stackoverflow.com/users/7282573/half"
              },
              "is_answered": true,
              "view_count": 71788,
              "accepted_answer_id": 56433885,
              "answer_count": 15,
              "score": 410,
              "last_activity_date": 1684454891,
              "creation_date": 1559591221,
              "last_edit_date": 1634238672,
              "question_id": 56433665,
              "content_license": "CC BY-SA 4.0",
              "link": "https://stackoverflow.com/questions/56433665/what-is-the-some-keyword-in-swiftui",
              "title": "What is the &quot;some&quot; keyword in Swift(UI)?"
            },
            {
              "tags": [
                "ios",
                "swift",
                "swiftui"
              ],
              "owner": {
                "reputation": 5264,
                "user_id": 5479510,
                "user_type": "registered",
                "profile_image": "https://i.stack.imgur.com/ii5Uy.jpg?s=256&g=1",
                "display_name": "inokey",
                "link": "https://stackoverflow.com/users/5479510/inokey"
              },
              "is_answered": true,
              "view_count": 267123,
              "accepted_answer_id": 56649668,
              "answer_count": 14,
              "score": 302,
              "last_activity_date": 1679297059,
              "creation_date": 1559649898,
              "last_edit_date": 1559731756,
              "question_id": 56443535,
              "content_license": "CC BY-SA 4.0",
              "link": "https://stackoverflow.com/questions/56443535/swiftui-text-alignment",
              "title": "SwiftUI text-alignment"
            }
          ],
          "has_more":true,
          "quota_max":300,
          "quota_remaining":257
        }
        """
        
        if let data = jsonString.decoded(QuestionList.self) {
            completion(.success(data))
        }
    }
}


