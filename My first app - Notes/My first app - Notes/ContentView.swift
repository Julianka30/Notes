//
//  ContentView.swift
//  My first app - Notes
//
//  Created by Julia on 6/20/22.
//

import SwiftUI

struct Note: Identifiable, Codable,Equatable {
    var id = UUID()
    
    // хранит данные конкретной заметки
    var title: String
    var date: Date
    var noteBody: String
}

private let path = "/Users/julia/Desktop/Notes.json"


struct ContentView: View {
    @State private var notes: [Note] = []
//        Note(title: "Note 1", date: Date(), noteBody: "Hello,I am Julia hdjssksksncnckskksksncmcl"),
//        Note(title: "Note 2", date: Date(), noteBody: "Hello,I am Vova")
   
    @State var selectedNoteId: UUID?
    
   
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    notes.append(Note(title: "New Note", date: Date(), noteBody: "No text"))
                   selectedNoteId = notes.last?.id

                    
                }) {
                    Image (systemName: "square.and.pencil")
                }
                Spacer()
    
//                Button(action: { writeArrayOfNotes(notes) }) {
//                    Text("Save")
//                }
//                Spacer()
//                Button(action: { notes = readArrOfNotes() }) {
//                    Text("Download")
//                }
//                Spacer()
                Button(action: {
                    if selectedNoteId == notes.last?.id {
                        notes.removeLast()
                        selectedNoteId = notes.last?.id
                        return
                    }
                    
                    guard let indexToRemove = notes.firstIndex(where: { $0.id == selectedNoteId }) else {
                        return
                    }
            
                    let newIndex = notes.index(after: indexToRemove)
                  
                    let newSelectedNote = notes[newIndex]
                    selectedNoteId = newSelectedNote.id
                    
                    notes.remove(at: indexToRemove)
                }) {
                    Image (systemName: "trash.fill")
                }.disabled(selectedNoteId == nil)
            }
            
            HStack {
                NoteList(notes: notes, id: $selectedNoteId)
                    .frame(width: 200)

                Spacer()
                Divider()
                if let selectedNote = findSelectedNote() {
                    NoteBody(note: selectedNote)
                }
                    
//                    Text(findSelectedNote()?.title ?? "Empty")
//                    Spacer()
            }
        }.background(.white)
        .onChange(of: notes) { newValue in
            writeArrayOfNotes(newValue)
        }
        .onAppear {
            notes = readArrOfNotes()
        }
    }
    
    
    func findSelectedNote() -> Binding<Note>? {
        $notes.first { $0.id == selectedNoteId }
//        for note in $notes {
//            if note.id == selectedNoteId {
//                return note
//            }
//        }
//        return nil
    }
  
    func findNewSelectedNoteID() -> UUID? {
        guard let firstIndex = notes.firstIndex(where: { $0.id == selectedNoteId }) else {
            return nil
        }
        let newIndex = notes.index(after: firstIndex)
        let newSelectedNote = notes[newIndex]
        return newSelectedNote.id
    }
    
    func readArrOfNotes() -> [Note] {
        guard FileManager.default.fileExists(atPath: path) else {
            return []
        }
        let url = URL(fileURLWithPath: path)
        let data = try! Data (contentsOf: url)
        guard !data.isEmpty else {
            return []
        }
        let dec = JSONDecoder()
        let arrOfNotes = try! dec.decode([Note].self, from: data)
        return arrOfNotes
    }
    func writeArrayOfNotes(_ arrayStruct:[Note]) {
        let enc = JSONEncoder()
        enc.outputFormatting = .prettyPrinted
        let json = try! enc.encode(arrayStruct)
        let url = URL (fileURLWithPath:path)
        try! json.write (to: url)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 400, height: 300)
    }
}
