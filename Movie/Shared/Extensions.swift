//
//  Extensions.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation
import UIKit

extension String{
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return (self as NSString).integerValue
    }
    var boolValue: Bool{
        return (self as NSString).boolValue
    }
}
extension UIImageView {
    func download(url: String, mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
