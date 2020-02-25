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

  weak var delegate: MessagesListControllerDelegate?

  // MARL: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
  }

  // MARK: - Subviews

  @IBOutlet var sortingButton: NSPopUpButton!
  @IBOutlet var tableView: NSTableView!

  // MARK: - State

  var messages = [Message]() {
    didSet {
      tableView.reloadData()
    }
  }

  var sortOrder: SortOrder {
    get {
      switch sortingButton.indexOfSelectedItem {
        case 0: return .date
        case 1: return .senderName
        default: fatalError("Unknown sort order")
      }
    }
  }

  // MARK: - Actions

  @IBAction func selectedSortOrder(_ sender: Any?) {
    delegate?.didChangeSortOrder(sortOrder)
  }
}

// MARK: - Delegate protocol

protocol MessagesListControllerDelegate: class {
  func didChangeSelection(message: Message?)
  func didChangeSortOrder(_ sortOrder: SortOrder)
}

// MARK: - Auxilary types

enum SortOrder {
  case date, senderName
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

  func tableViewSelectionDidChange(_ notification: Notification) {
    let selectedMessage = tableView.selectedRow >= 0
      ? messages[tableView.selectedRow]
      : nil
    delegate?.didChangeSelection(message: selectedMessage)
  }
}
