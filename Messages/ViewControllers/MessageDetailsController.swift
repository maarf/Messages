//
//  MessageDetailsController.swift
//  Messages
//
//  Created by Martins on 25/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import AppKit
import Model

final class MessageDetailsController: NSViewController {

  // MARK: - State

  var message: Message? {
    didSet {
      guard let message = message else { return }
      senderNameLabel.stringValue = message.senderName
      recipientNameLabel.stringValue = message.recipientName
      subjectLabel.stringValue = message.subject
      dateLabel.stringValue = dateFormatter.string(from: message.receivedAt)
    }
  }

  // MARK: - Subviews

  @IBOutlet var senderNameLabel: NSTextField!
  @IBOutlet var recipientNameLabel: NSTextField!
  @IBOutlet var subjectLabel: NSTextField!
  @IBOutlet var dateLabel: NSTextField!
  @IBOutlet var avatar: NSImageView!
  @IBOutlet var textView: NSTextView!
}

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .short
  return formatter
}()
