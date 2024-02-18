//
//  DetailQuestionModel.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/24/23.
//

import UIKit

// MARK: - DetailQuestion
struct DetailQuestion: Codable {
    let items: [DetailItem]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct DetailItem: Codable {
    let tags: [String]
    let owner: DetailOwner
    let isAnswered: Bool
    let viewCount, acceptedAnswerID, answerCount, score: Int
    let lastActivityDate, creationDate, lastEditDate, questionID: Int
    let contentLicense: String
    let link: String
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case acceptedAnswerID = "accepted_answer_id"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case link, title, body
    }
}

// MARK: - Owner
struct DetailOwner: Codable {
    let reputation, userID: Int
    let userType: String
    let profileImage: String
    let displayName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
}
