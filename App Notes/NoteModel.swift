//
//  NoteModel.swift
//  App Notes
//
//  Created by raul Mejia on 14/7/23.
//

import Foundation

struct NoteModel: Codable {
    let id : String
    var isFavorited : Bool
    var description : String
    
    init(id: String = UUID().uuidString, isFavorited: Bool = false, description: String) {
        self.id = id
        self.isFavorited = isFavorited
        self.description = description
    }
    
}
