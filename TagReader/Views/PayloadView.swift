//
//  PayloadView.swift
//  TagReader
//
//  Created by Ken Tsutsumi on 2023/03/04.
//

import SwiftUI

struct PayloadView: View {
  @State var payload: Payload
  
  var body: some View {
    Text(payload.text)
  }
}

struct MessageView_Previews: PreviewProvider {
  static var previews: some View {
    let payload = Payload(text: "タイトル")
    PayloadView(payload: payload)
  }
}
