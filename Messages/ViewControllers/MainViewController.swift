//
//  MainViewController.swift
//  Messages
//
//  Created by Martins on 25/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import Cocoa

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
  }
}
