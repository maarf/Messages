//
//  Message.swift
//  Model
//
//  Created by Martins on 25/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

public struct Message {

  public let senderName: String
  public let senderEmail: String
  public let recipientName: String
  public let recipientEmail: String
  public let receivedAt: Date
  public let subject: String
  public let body: String
  public let isRead: Bool

  public init(
    senderName: String,
    senderEmail: String,
    recipientName: String,
    recipientEmail: String,
    receivedAt: Date,
    subject: String,
    body: String,
    isRead: Bool = false
  ) {
    self.senderName = senderName
    self.senderEmail = senderEmail
    self.recipientName = recipientName
    self.recipientEmail = recipientEmail
    self.receivedAt = receivedAt
    self.subject = subject
    self.body = body
    self.isRead = isRead
  }
}

extension Message: Codable {}
