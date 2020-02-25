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

    self.messagesList.delegate = self
    self.messagesList.messages = testMessages.sorted(by: .date)
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
      receivedAt: Date(timeIntervalSince1970: 1582558880),
      subject: "Older test message",
      body: "Older message body"),
    Message(
      senderName: "Bertrand",
      senderEmail: "bertrand@example.com",
      recipientName: "Johnny",
      recipientEmail: "johnyy@example.com",
      receivedAt: Date(timeIntervalSince1970: 1582238880),
      subject: "ASAP as possible",
      body: "This is important!"),
    Message(
      senderName: "Katherin",
      senderEmail: "kat@example.com",
      recipientName: "Johnny",
      recipientEmail: "johnyy@example.com",
      receivedAt: Date(timeIntervalSince1970: 1582629000),
      subject: "The latest news",
      body: "Fresh off the press")
  ]
}

// MARK: - Messages list controller delegate

extension MainViewController: MessagesListControllerDelegate {
  func didChangeSelection(message: Message?) {
    messageDetails.message = message
  }

  func didChangeSortOrder(_ sortOrder: SortOrder) {
    messagesList.messages = testMessages.sorted(by: sortOrder)
  }
}

// MARK: - Message sorting by order

extension Array where Element == Message {
  func sorted(by sortOrder: SortOrder) -> Self {
    switch sortOrder {
      case .date:
        // This is descending date order
        return sorted { $0.receivedAt > $1.receivedAt }
      case .senderName:
        return sorted { $0.senderName < $1.senderName }
    }
  }
}
