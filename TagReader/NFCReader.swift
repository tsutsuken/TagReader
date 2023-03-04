//
//  NFCReader.swift
//  TagReader
//
//  Created by Ken Tsutsumi on 2023/03/04.
//

import CoreNFC
import Foundation

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
  @Published var messages: [Message] = []
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
    setMessages(messages: messages)
  }
  
  // MARK: Private functions
  
  private func setMessages(messages: [NFCNDEFMessage]) {
    var newMessages: [Message] = []
    for message in messages {
      for record in message.records {
        let payload = record.payload
        if let payloadText = String(data: payload, encoding: .utf8) {
          let newMessage = Message(text: payloadText)
          newMessages.append(newMessage)
        }
      }
    }
    self.messages = newMessages
  }
}
