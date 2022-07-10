//
//  PhotoInfo.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 09.Jun.22.
//

import Foundation


class PhotoInfo: Codable {
    
    private let name: String
    private var likeState: Bool = false
    private var comments: [Comment] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addComment(comment: Comment) {
        comments.append(comment)
    }
    
    func getComments() -> [Comment] {
        comments
    }
    
    func getName() -> String {
        name
    }
    
    func setLikeState() {
        likeState.toggle()
    }
    
    func getLikeState() -> Bool {
        likeState
    }
}
