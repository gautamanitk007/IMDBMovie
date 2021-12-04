//
//  Utils.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import UIKit
import Foundation
import SystemConfiguration
class Utils {
    class func getAlert(title:String,message:String) -> UIAlertController {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover
        alert.addAction(UIAlertAction(title:Utils.getLocalisedValue(key:"Button_OK_Title"), style: .default) { _ in})
        return alert
    }
    class func load<T:Decodable>(bundle:Bundle, fileName: String) -> T?{
        do{
            let data = try bundle.path(forResource: fileName, ofType: "json",inDirectory: nil).flatMap({ jPath in
                return try Data(contentsOf: URL(fileURLWithPath: jPath))
            })
            let response: T? = try data.flatMap({ jsonData in
                return try JSONDecoder().decode(T.self, from: jsonData)
            })
            return response
        }catch {
            print("Failed to load data")
        }
        return nil
    }
    
    class func getLocalisedValue(key:String) -> String{
        return NSLocalizedString(key,comment: "")
    }
    class func getViewController(identifier:String) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
