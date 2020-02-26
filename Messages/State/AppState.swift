//
//  AppState.swift
//  Messages
//
//  Created by Martins on 26/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import Model

/// A very simple app state struct.
///
/// This should only be modified in a single place (like aa state store, but we
/// will keep it even simpler and do it in MainViewController).
struct AppState {
  var sortOrder = SortOrder.date
  var messages = [Message]()
}

enum SortOrder {
  case date, senderName
}
