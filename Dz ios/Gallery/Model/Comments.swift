//
//  Comments.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 09.Jun.22.
//

import Foundation


class Comment: Codable {
    
    private let body: String
    private let date: String
    
    
    init(body: String, date: String) {
        self.body = body
        self.date = date
    }
    
    func getTextBody() -> String {
        body
    }
    
    func getDate() -> String {
        date
    }
    
}
