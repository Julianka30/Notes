//
//  NoteList.swift
//  My first app - Notes
//
//  Created by Julia on 6/27/22.
//

import SwiftUI

struct NoteList: View { // сколько заметок и как расположить между собой
    let notes: [Note]
    @Binding var id: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(notes) { note in
                NoteListItem(note: note, isSelected: note.id == id)
                    .contentShape(Rectangle())
                    .onTapGesture { id = note.id }
                Divider()
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .contentShape(Rectangle())
        .onTapGesture { id = nil }
    }
}

private struct NoteListItem: View { // отображает конкретную заметку в списке(внутри элемента списка)
    let note: Note //state
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(note.title)
                .font(.headline)
            HStack {
                Text(note.date.noteShortFormatted)
                Text (note.noteBody)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
           
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isSelected ? Color.yellow : Color.clear)
        .cornerRadius(8)
    }
}

extension Date {
    var noteShortFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
//        NoteListItem(note: .init(title: "Qwe", date: Date(), noteBody: "qqqqqqqqqqqqqqqqqqq"), isSelected: true)
//            .frame(width: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 5, style: .circular))
        NoteList(
            notes: [
                Note(title: "Note 1", date: Date(), noteBody: "Hello,I am ggtyg gy7 gy7 g7ygy7g7 g7ygy7g7 gy7 g 7yg y7 gy7g 7tft6dfrf Julia"),
                Note(title: "Note 2", date: Date(), noteBody: "Hello,I am Vova")
            ], id: .constant(nil)
        ).frame(width: 400, height: 400)
    }
}
