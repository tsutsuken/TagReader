//
//  MessageView.swift
//  TagReader
//
//  Created by Ken Tsutsumi on 2023/03/04.
//

import SwiftUI

struct MessageView: View {
  @State var message: Message
  
  var body: some View {
    Text(message.text)
  }
}

struct MessageView_Previews: PreviewProvider {
  static var previews: some View {
    let message = Message(text: "メッセージ")
    MessageView(message: message)
  }
}
