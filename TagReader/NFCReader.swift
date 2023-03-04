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
  
  func stopSession() {
      session?.invalidate()
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
      for payload in message.records {
        if let payloadContent = payloadContent(payload: payload) {
          let newMessage = Message(text: payloadContent)
          newMessages.append(newMessage)
        }
      }
    }
    self.messages = newMessages
  }
  
  private func payloadContent(payload: NFCNDEFPayload) -> String? {
    guard let type = String(data: payload.type, encoding: .utf8) else {
      return nil
    }
    
    if type == "T" {
      // PayloadがTextの場合
      let (payloadText, _) = payload.wellKnownTypeTextPayload()
      print("payloadText: \(payloadText ?? "")")
      return payloadText
    } else if type == "U" {
      // PayloadがURIの場合
      let payloadURI = payload.wellKnownTypeURIPayload()
      print("payloadURI: \(payloadURI?.absoluteString ?? "")")
      return payloadURI?.absoluteString
    } else {
      // その他の場合
      print("未対応のPayloadTypeです。")
      return nil
    }
  }
}
