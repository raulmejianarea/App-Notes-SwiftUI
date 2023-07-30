//
//  ContentView.swift
//  App Notes
//
//  Created by raul Mejia on 14/7/23.
//

import SwiftUI

struct ContentView: View {
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    @ObservedObject private var brokenRules = NotesViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Añade una nota")
                    .foregroundColor(.gray)
                    .padding(.horizontal,16)
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.gray)
                    .frame(height: 100)
                    .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)
                
                ForEach(notesViewModel.brokenRules, id: \.message){ brokenRule in
                    Text(brokenRule.message)
                }
                
                
                Button("Crear"){
                    print("creando nota...")
                  notesViewModel.saveNotes(description: descriptionNote)
                    descriptionNote = ""
                }
                .buttonStyle(.bordered)
                .tint(.green)
                Spacer()
                List{
                    ForEach($notesViewModel.notes, id: \.id){ $note in
                        HStack{
                            
                            if note.isFavorited {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }else{
                                Image(systemName: "star.fill")
                                    .foregroundColor(.gray)
                            }
                            Text(note.description)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                notesViewModel.updateFavoriteNote(note: $note)
                            }label: {
                                Label("favorito", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                notesViewModel.removeNote(withid: note.id)                            }label: {
                                Label("borrar", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Listado de Notas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(notesViewModel.getNumberOfNotes())
            }
    
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\..colorScheme, .dark)
        ContentView()
        
    }
}
