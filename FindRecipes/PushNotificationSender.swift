//
//  PushNotificationSender.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/24/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Firebase
class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,"notification" : ["title" : title, "body" : body],"data" : ["user" : "test_id"]
        //let paramString: [String : Any] = ["to" : token, "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAqsCtIwY:APA91bENkCrAFaUYNo1pl2Ozl-399xdl-aT_udDn05KkMiXtvyyMXh6lYFX5SbnfqqnnXR-E-ebENvr6_wb86QW7qFk1xE-CuTguQd146Dw-lTAkMkr5yRjCcKWBmHNehBas7gMU7E8f", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
