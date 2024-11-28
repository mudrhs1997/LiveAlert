//
//  UNUserNotificationCenter+Extentions.swift
//  Common
//
//  Created by 정명곤 on 11/28/24.
//

import Foundation


extension UNUserNotificationCenter {
  func addNotificationRequest(by date: DateComponents, id: String) {

    let content = UNMutableNotificationContent()
    content.title = "title"
    content.body = "body"
    content.sound = .default

    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

    self.add(request) { error in
      return false
    }

    return true
  }
}
