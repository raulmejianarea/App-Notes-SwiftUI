//
//  NotesViewModel.swift
//  App Notes
//
//  Created by raul Mejia on 14/7/23.
//

import Foundation
import SwiftUI

final class NotesViewModel: ObservableObject  {
    @Published var notes : [NoteModel] = []
    @Published var brokenRules = [BrokenRuleModel]()
    
    init() {
        self.notes = getAllNotes()
    }
    
    func saveNotes(description: String)  {
        
        if(validate(description: description)){
            let newNote = NoteModel(description: description)
            notes.insert(newNote, at: 0)
            encodeAndSaveAllNotes()
        }
  
    }
    private func validate(description: String) -> Bool {
        brokenRules.removeAll()
        
        if description.isEmpty{
            brokenRules.append(BrokenRuleModel(message: "Descripcion no puede estar vacio!"))
        }
        
        return brokenRules.count == 0
        
    }
    private func encodeAndSaveAllNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data{
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
                
            }
        }
        return []
    }
    func removeNote(withid id: String)  {
        notes.removeAll(where: {$0.id == id})
        encodeAndSaveAllNotes()
        
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>) {
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encodeAndSaveAllNotes()
        
    
    }
    func getNumberOfNotes() -> String {
        "\(notes.count)"
    }
    
    
}
