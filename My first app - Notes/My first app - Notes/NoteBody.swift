//
//  NoteBody.swift
//  My first app - Notes
//
//  Created by Julia on 6/27/22.
//

import SwiftUI

struct NoteBody: View {
    @Binding var note: Note
    var body: some View {
        VStack {
            Text(note.date.noteStringFormatted)
                .foregroundColor(.gray)
                .font(.caption)
            TextField("Placeholder...", text: $note.title)
                .onChange(of: note.title) { newValue in
                    note.date = Date()
                }.textFieldStyle(.plain)
                .font(.headline)
                .padding(.bottom)
            TextEditor(text: $note.noteBody)
                .onChange(of: note.noteBody) { newValue in
                    note.date = Date()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
        }
    }
}
extension Date {
    var noteStringFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyy, HH:mm"
        return formatter.string(from: self)
    }
}


struct NoteBody_Previews: PreviewProvider {
    struct Dummy: View {
        @State var note = Note(title: "Title", date: Date(), noteBody: "Notebody")
        
        var body: some View {
            NoteBody(note: $note)
                .frame(width: 400, height: 400)
        }
    }
    
    static var previews: some View {
        Dummy()
    }
}
