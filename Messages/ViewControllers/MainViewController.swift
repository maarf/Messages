//
//  MainViewController.swift
//  Messages
//
//  Created by Martins on 25/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import Cocoa
import Model

final class MainViewController: NSSplitViewController {

  // MARK: - Subcontrollers

  var messagesList: MessagesListController!
  var messageDetails: MessageDetailsController!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    guard
      let messagesList = splitViewItems[0].viewController
        as? MessagesListController,
      let messageDetails = splitViewItems[1].viewController
        as? MessageDetailsController
    else {
      fatalError("Can't find message list and details controllers")
    }
    self.messagesList = messagesList
    self.messageDetails = messageDetails

    self.messagesList.messages = testMessages
  }

  // MARK: Testing

  private lazy var testMessages = [
    Message(
      senderName: "Chad",
      senderEmail: "chad@example.com",
      recipientName: "Johnny",
      recipientEmail: "johnyy@example.com",
      receivedAt: Date(timeIntervalSince1970: 1582628880),
      subject: "Test message",
      body: "Message body"),
    Message(
      senderName: "Amy",
      senderEmail: "amy@example.com",
      recipientName: "Johnny",
      recipientEmail: "johnyy@example.com",
      receivedAt: Date(timeIntervalSince1970: 1582618880),
      subject: "Older test message",
      body: "Older message body")
  ]
}
