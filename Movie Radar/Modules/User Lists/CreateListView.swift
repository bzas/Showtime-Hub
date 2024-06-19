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
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: UserListsView.ViewModel
    @Query(sort: [
        SortDescriptor(\UserList.index)
    ]) var currentLists: [UserList]
    @FocusState var isEditingField: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Text("Create a new list")
                        .font(.system(size: 30, weight: .light))
                    Spacer()
                }
                
                HStack {
                    VStack(spacing: 2) {
                        TextField("", text: $viewModel.listName)
                            .focused($isEditingField)
                            .modifier(
                                PlaceholderStyle(
                                    showPlaceHolder: viewModel.listName.isEmpty,
                                    placeholder: NSLocalizedString("Name", comment: "")
                                )
                            )
                        
                        if viewModel.isNameInUse(lists: currentLists) {
                            VStack(spacing: 0) {
                                Color.red
                                    .frame(height: 1)
                                HStack {
                                    Spacer()
                                    Text("This list already exists")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.red)
                                }
                            }
                        } else {
                            Color.white.opacity(0.5)
                                .frame(height: 1)
                        }
                    }
                    
                    if isEditingField {
                        Button(action: {
                            isEditingField = false
                        }, label: {
                            Text("Done")
                                .foregroundStyle(.white)
                        })
                        .padding(.trailing, 10)
                    }
                }
                .padding(.vertical)
                
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
                .padding(.vertical)
                
                VStack {
                    HStack{
                        Text("Background")
                        Spacer()
                    }
                    
                    BackgroundPickerView(
                        listBackgroundType: $viewModel.listBackgroundType,
                        listBackgroundIndex: $viewModel.listBackgroundIndex
                    )
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            viewModel.tabIndex = 0
                        }
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.white)
                            .padding()
                    })
                    Button(action: {
                        viewModel.createList(currentLists: currentLists)
                    }, label: {
                        let shouldDisableButton = viewModel.listName.isEmpty || viewModel.isNameInUse(lists: currentLists)
                        Text("Create")
                            .foregroundStyle(.black)
                            .padding()
                            .background(.white)
                            .clipShape(Capsule())
                            .disabled(shouldDisableButton)
                            .opacity(shouldDisableButton ? 0.5 : 1)
                    })
                }
                .padding(.bottom)
            }
            .padding(.vertical, 40)
            .padding(.bottom, 40)
        }
        .padding(.top)
        .padding(.horizontal, 25)
        .scrollIndicators(.hidden)
        .sheet(isPresented: $viewModel.isSelectingNewIcon) {
            SymbolsPicker(
                selection: $viewModel.listIcon,
                title: "Pick a list icon",
                autoDismiss: true
            )
        }
        .onChange(of: viewModel.tabIndex, { _, newValue in
            if newValue == 0 {
                isEditingField = false
            }
        })
    }
}
