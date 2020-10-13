//: [Previous](@previous)

import UIKit

class SuiRouter: NSObject {
    static var bundleVersion: String {
        let s = self.description().replacingOccurrences(of: ".Playground", with: "")
        return s
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}

enum SuiRouterShowType {
    case push
    case pop
    case popTo
    case popToRoot
    case present
}

protocol SuiRouterProtocol {
    
}


class TestRouter: NSObject,SuiRouterProtocol {
    
}

class TextViewController: UIViewController {
    
}


//: [Next](@next)
