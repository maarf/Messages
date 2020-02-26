//
//  GravatarService.swift
//  Messages
//
//  Created by Martins on 26/02/2020.
//  Copyright © 2020 Martins Spilners. All rights reserved.
//

import AppKit
import CommonCrypto

final class GravatarService {

  static let gravatarBaseURL = URL(string: "https://www.gravatar.com/avatar/")

  private var dataTask: URLSessionDataTask?

  deinit {
    dataTask?.cancel()
  }

  /// Fetches an avatar image from Gravatar.
  ///
  /// Provides a default image while Gravatar image is being downloaded or if it
  /// is not available. Therefore `updateHandler` can be called multiple times.
  func fetchAvatar(
    forEmail email: String,
    updateHandler: @escaping (NSImage) -> Void
  ) {
    updateHandler(NSImage(named: "DefaultAvatar")!)
    let hashedEmail = email
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .lowercased()
      .md5Hashed()
    var components = URLComponents(string: hashedEmail)!
    components.queryItems = [URLQueryItem(name: "d", value: "identicon")]
    let url = components.url(relativeTo: Self.gravatarBaseURL)!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        error == nil,
        let data = data,
        let image = NSImage(data: data)
      else {
        // Failed to load the gravatar image, but we don't want to report this
        // since it might happen just because there's no internet connection
        // available.
        return
      }
      updateHandler(image)
    }
    task.resume()
    dataTask = task
  }
}

extension String {
  // Adapted from https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift
  func md5Hashed() -> String {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    let messageData = data(using:.utf8)!
    var digestData = Data(count: length)
    _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
      messageData.withUnsafeBytes { messageBytes -> UInt8 in
        if
          let messageBytesBaseAddress = messageBytes.baseAddress,
          let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress
        {
          let messageLength = CC_LONG(messageData.count)
          CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
        }
        return 0
      }
    }
    return digestData.map { String(format: "%02hhx", $0) }.joined()
  }
}
