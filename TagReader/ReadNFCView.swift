//
//  ReadNFCView.swift
//  TagReader
//
//  Created by Ken Tsutsumi on 2023/03/03.
//

import CoreNFC
import SwiftUI

struct ReadNFCView: View {
  @ObservedObject var reader = NFCReader()
  var body: some View {
      VStack {
          Text("読み取りしたNFCタグ: ")
          Button("NFCを読み取る") {
            reader.scan()
          }
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
  }
}

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
  private var session: NFCNDEFReaderSession?
  
  func scan() {
      session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
      session?.begin()
  }
  
  // MARK: NFCNDEFReaderSessionDelegate
  
  func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    print("readerSession session: \(session) didInvalidateWithError: \(error.localizedDescription)")
  }
  
  func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    print("readerSession session: \(session) didDetectNDEFs: \(messages)")
    for message in messages {
      for record in message.records {
        let payload = record.payload
        if let payloadText = String(data: payload, encoding: .utf8) {
            print(payloadText)
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
