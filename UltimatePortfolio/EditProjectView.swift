//
//  EditProjectView.swift
//  UltimatePortfolio
//
//  Created by Alejandro Mendoza on 27/01/22.
//

import SwiftUI

struct EditProjectView: View {
    let project: Project
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String
    @State var detail: String
    @State var color: String
    @State var showingDeleteConfirm = false
    
    let colorColums = [ GridItem(.adaptive(minimum: 44)) ]
    
    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }
    
    var body: some View {
        Form {
            
            Section {
                TextField("Project title", text: $title.onChange(update))
                TextField("Description of this project", text: $detail.onChange(update))
            } header: {
                Text("Basic settings")
            }
            
            Section {
                LazyVGrid(columns: colorColums) {
                    ForEach(Project.colors, id: \.self) { item in
                        ZStack {
                            Color(item)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            
                            if(color == item) {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .onTapGesture {
                            color = item
                            update()
                        }
                    }
                }
                .padding(.vertical)
            } header: {
                Text("Custom project color")
            }
            
            Section {
                Button(project.closed ? "Reopen this project" : "Close this project") {
                    project.closed.toggle()
                    update()
                }
                Button("Delete this project") {
                    showingDeleteConfirm.toggle()
                }
                .tint(.red)
            } footer: {
                Text("Closing a project moves it to the closed tap; deleting it removes the project entirely")
            }


        }
        .navigationTitle("Edit project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete project?"),
                  message: Text("Are you sure you want to delete this project, you'll also delete all its items."),
                  primaryButton: .default(Text("Delete"), action: delete),
                  secondaryButton: .cancel())
        }
    }
    
    func update() {
        project.title = title
        project.detail = detail
        project.color = color
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProjectView(project: Project.example)
        }
    }
}
