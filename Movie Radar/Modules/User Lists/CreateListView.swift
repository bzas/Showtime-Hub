//
//  CreateListView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/6/24.
//

import SwiftUI
import SFSymbolsPicker
import SwiftData

struct CreateListView: View {
    @EnvironmentObject var viewModel: UserListsView.ViewModel
    @Query var currenLists: [UserList]
    @FocusState var isEditing: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                HStack {
                    Text("Create a new list")
                        .font(.system(size: 30, weight: .light))
                    Spacer()
                }
                VStack(spacing: 2) {
                    TextField("", text: $viewModel.listName)
                        .focused($isEditing)
                        .modifier(PlaceholderStyle(showPlaceHolder: viewModel.listName.isEmpty,
                                                   placeholder: NSLocalizedString("Name", comment: "")))
                    
                    Color.white.opacity(0.5)
                        .frame(height: 1)
                }
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Icon")
                        Spacer()
                        Button {
                            viewModel.isSelectingNewIcon.toggle()
                        } label: {
                            Image(systemName: viewModel.listIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 25, maxHeight: 25)
                        }
                    }
                    .padding()
                    .padding(.trailing, 2)
                    
                    Color.gray
                        .opacity(0.2)
                        .frame(height: 1)
                    
                    ColorPicker(
                        "Color",
                        selection: $viewModel.listColor
                    )
                    .padding()
                }
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isEditing = false
                            viewModel.tabIndex = 0
                        }
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.white)
                            .padding()
                    })
                    Button(action: {
                        isEditing = false
                        viewModel.createList(index: currenLists.count)
                        withAnimation {
                            viewModel.tabIndex = 0
                        }
                    }, label: {
                        Text("Create")
                            .foregroundStyle(.black)
                            .padding()
                            .background(.white)
                            .clipShape(Capsule())
                            .disabled(viewModel.listName.isEmpty)
                            .opacity(viewModel.listName.isEmpty ? 0.5 : 1)
                    })
                }
                .padding(.vertical)
            }
            .padding(.top, 40)
        }
        .padding(.horizontal, 25)
        .sheet(isPresented: $viewModel.isSelectingNewIcon) {
            SymbolsPicker(
                selection: $viewModel.listIcon,
                title: "Pick a list icon",
                autoDismiss: true
            )
        }
    }
}
