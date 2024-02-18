//
//  StringProtocol+Extension.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/24/23.
//

import Foundation

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

public extension String {
    
    func decoded<T: Decodable>(_ type: T.Type) -> T? {
        let jsonData = Data(self.utf8)
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(type, from: jsonData)
            return response
        } catch {
            return nil
        }
    }
}
