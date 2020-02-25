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

  // MARK: - Lifecycle

  override func viewDidLoad() {
    // Constrain scroll view and its document view widths to equal
    documentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  }

  // MARK: - State

  var message: Message? {
    didSet {
      guard let message = message else { return }
      senderNameLabel.stringValue = message.senderName
      recipientNameLabel.stringValue = message.recipientName
      subjectLabel.stringValue = message.subject
      dateLabel.stringValue = dateFormatter.string(from: message.receivedAt)
      bodyLabel.stringValue = message.body
    }
  }

  // MARK: - Subviews

  @IBOutlet var scrollView: NSScrollView!
  @IBOutlet var documentView: FlippedView!
  @IBOutlet var senderNameLabel: NSTextField!
  @IBOutlet var recipientNameLabel: NSTextField!
  @IBOutlet var subjectLabel: NSTextField!
  @IBOutlet var dateLabel: NSTextField!
  @IBOutlet var avatar: NSImageView!
  @IBOutlet var bodyLabel: NSTextField!
}

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .short
  return formatter
}()

// This is a simply a flipped NSView so that the scroll view positions it at the
// top
final class FlippedView: NSView {
  override var isFlipped: Bool { true }
}
