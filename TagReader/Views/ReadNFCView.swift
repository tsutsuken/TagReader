//
//  ReadNFCView.swift
//  TagReader
//
//  Created by Ken Tsutsumi on 2023/03/03.
//

import SwiftUI

struct ReadNFCView: View {
  @ObservedObject var reader = NFCReader()
  
  var body: some View {
    VStack {
        Button("NFCを読み取る") {
          reader.scan()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
      List(reader.messages) { message in
        Section {
          MessageView(message: message)
        } header: {
          Text("読み取りしたNFCタグ一覧")
        }
      }
    }
  }
}

struct ReadNFCView_Previews: PreviewProvider {
    static var previews: some View {
        ReadNFCView()
    }
}
