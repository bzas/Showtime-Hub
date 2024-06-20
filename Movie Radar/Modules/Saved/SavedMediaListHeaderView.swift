//
//  SavedMediaListHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/6/24.
//

import SwiftUI
import SwiftData

struct SavedMediaListHeaderView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    var userList: UserList
    var mediaItems: [SavedMedia]
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 10) {
                    if let emoji = userList.emoji {
                        Text(emoji)
                            .font(.system(size: 30))
                    } else {
                        Image(systemName: userList.imageName ?? "")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(userList.colorInfo?.color ?? .white)
                            .frame(width: 25, height: 25)
                            .shadow(radius: 2)
                    }
                    Text(userList.title ?? "")
                        .lineLimit(5)
                        .font(.system(size: 25, weight: .light))
                        .shadow(radius: 2)
                        .shadow(radius: 2)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    withAnimation(.spring) {
                        viewModel.showUserLists.toggle()
                    }
                } label: {
                    Text("My lists")
                        .font(.system(size: 16))
                        .frame(height: 40)
                        .padding(.horizontal, 20)
                        .clipShape(Capsule())
                        .background(
                            Capsule()
                                .fill(.regularMaterial)
                        )
                }
                .padding(.bottom, 30)
                
                HStack {
                    Text("\(mediaItems.count)")
                        .font(.system(size: 50, weight: .semibold))
                        .shadow(radius: 2)
                    Text(mediaItems.count != 1 ? "items" : "item")
                        .shadow(radius: 2)
                }
                .padding()
                
                let isDefaultList = userList.listType == .defaultList
                HStack {
                    Button {
                        viewModel.listToDelete = userList
                    } label: {
                        VStack {
                            Image(systemName: isDefaultList ? "trash.slash.fill" : "trash.fill")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Delete")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                    .disabled(isDefaultList)
                    
                    Spacer()
                    
                    Button {
                        viewModel.listNewName = userList.title ?? ""
                    } label: {
                        VStack {
                            Image(systemName: isDefaultList ? "pencil.slash" : "pencil")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Rename")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                    .disabled(isDefaultList)
                    
                    Spacer()
                    
                    Menu {
                        Button {
                            viewModel.iconEditionList = userList
                        } label: {
                            Label(
                                "Icon",
                                systemImage: "face.dashed"
                            )
                        }
                        .disabled(isDefaultList)
                        
                        Button {
                            viewModel.backgroundEditionList = userList
                        } label: {
                            Label(
                                "Background",
                                systemImage: "photo.fill"
                            )
                        }
                    } label: {
                        VStack {
                            Image(systemName: "paintpalette.fill")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Appearance")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                    
                    Spacer()

                    Button {
                        viewModel.showFilters.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "line.3.horizontal.decrease")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Filter")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                        .overlay {
                            if viewModel.filtersApplied {
                                HStack {
                                    Spacer()
                                    VStack {
                                        appGradient.value
                                            .clipShape(Circle())
                                            .frame(width: 10, height: 10)
                                        Spacer()
                                    }
                                }
                                .frame(width: 55, height: 55)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .padding(.vertical)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
        }
        .disabled(viewModel.showUserLists)
        .padding(.bottom, 10)
        .padding(.top)
    }
}
