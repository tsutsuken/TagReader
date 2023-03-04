//
//  ReadNFCView.swift
//  TagReader
//
//  Created by Ken Tsutsumi on 2023/03/03.
//

import SwiftUI

struct ReadNFCView: View {
  @StateObject var reader = NFCReader()
  
  var body: some View {
    NavigationView {
      List(reader.messages) { message in
        Section {
          MessageView(message: message)
        }
      }
      .navigationTitle("読み取り結果")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing){
            Button("NFCタグを読み取る") {
              reader.scan()
            }
        }
      }
    }
    .onDisappear() {
      reader.scan()
    }
  }
}

struct ReadNFCView_Previews: PreviewProvider {
    static var previews: some View {
        ReadNFCView()
    }
}
