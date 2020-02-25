//
//  MessagesListController.swift
//  Messages
//
//  Created by Martins on 25/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import AppKit
import Model

final class MessagesListController: NSViewController {

  // MARL: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
  }

  // MARK: - Subviews

  @IBOutlet var tableView: NSTableView!

  // MARK: - State

  var messages = [Message]()

}

// MARK: - Table view delegate and data source

extension MessagesListController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return messages.count
  }
}

extension MessagesListController: NSTableViewDelegate {
  func tableView(
    _ tableView: NSTableView,
    viewFor tableColumn: NSTableColumn?,
    row: Int
  ) -> NSView? {
    let messageCell =
      tableView.makeView(
        withIdentifier: MessageCell.defaultIdentifier,
        owner: self) as? MessageCell
      ?? MessageCell()
    messageCell.message = messages[row]
    return messageCell
  }
}
