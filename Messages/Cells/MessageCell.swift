//
//  MessageCell.swift
//  Messages
//
//  Created by Martins on 25/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import AppKit
import Model

final class MessageCell: NSTableCellView {

  override init(frame: NSRect) {
    super.init(frame: frame)
    identifier = Self.defaultIdentifier
    wantsLayer = true
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    identifier = Self.defaultIdentifier
    wantsLayer = true
  }

  override func updateLayer() {
     layer?.backgroundColor = message?.isRead == false
       ? NSColor(named: "UnreadMessageBackground")!.cgColor
       : NSColor.clear.cgColor
  }

  // MARK: - State

  var message: Message? {
    didSet {
      guard let message = message else { return }
      senderNameLabel.stringValue = message.senderName
      subjectLabel.stringValue = message.subject
      dateLabel.stringValue = dateFormatter.string(from: message.receivedAt)
      updateLayer()
    }
  }

  // MARK: - Subviews

  @IBOutlet var senderNameLabel: NSTextField!
  @IBOutlet var subjectLabel: NSTextField!
  @IBOutlet var dateLabel: NSTextField!
  @IBOutlet var avatar: NSImageView!

  // MARK: - Constants

  static let defaultIdentifier = NSUserInterfaceItemIdentifier("MessageCell")
}

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .none
  return formatter
}()
