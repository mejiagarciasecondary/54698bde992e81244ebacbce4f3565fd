//
//  UIImageView+Extensions.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import UIKit

public extension UIImageView {
    @discardableResult
    func load(url: String?) -> URLSessionDataTask? {
        guard let urlString = url,
              let url = URL(string: urlString) else {
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }

        task.resume()

        return task
    }
}
