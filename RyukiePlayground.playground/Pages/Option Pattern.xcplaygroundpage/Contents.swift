//: [Previous](@previous)

/*:
 > [Swift 中使用 Option Pattern 改善可选项的 API 设计](https://onevcat.com/2020/10/use-options-pattern/)
 */


import Foundation
import UIKit

public class TrafficLight {
    
    public enum State {
        case stop
        case proceed
        case caution
    }
    
    public private(set) var state: State = .stop {
        didSet { onStateChanged?(state) }
    }
    
    public var onStateChanged: ((State) -> Void)?
    
    private var options = [ObjectIdentifier: Any]()
    
    public subscript<T: TrafficLightOption>(option type: T.Type) -> T.Value {
        get {
            // 2
            options[ObjectIdentifier(type)] as? T.Value
                ?? type.defaultValue
        }
        set {
            options[ObjectIdentifier(type)] = newValue
        }
    }
    
    
    public var stopDuration = 4.0
    public var proceedDuration = 6.0
    public var cautionDuration = 1.5
    //    然后用一个 Timer 计时，并进行控制状态的转换：
    
    private var timer: Timer?
    
    private func turnState(_ state: State) {
        switch state {
        case .proceed:
            timer = Timer.scheduledTimer(withTimeInterval: proceedDuration, repeats: false) { _ in
                self.turnState(.caution)
            }
        case .caution:
            timer = Timer.scheduledTimer(withTimeInterval: cautionDuration, repeats: false) { _ in
                self.turnState(.stop)
            }
        case .stop:
            timer = Timer.scheduledTimer(withTimeInterval: stopDuration, repeats: false) { _ in
                self.turnState(.proceed)
            }
        }
        self.state = state
    }
    //    最后，向外提供开启和结束的方法就可以了：
    
    public func start() {
        guard timer == nil else { return }
        turnState(.stop)
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
}

extension TrafficLight {
    public enum GreenLightColor: TrafficLightOption {
        case green
        case turquoise

        public static let defaultValue: GreenLightColor = .green
    }
    
    public var preferredGreenLightColor: TrafficLight.GreenLightColor {
            get { self[option: GreenLightColor.self] }
            set { self[option: GreenLightColor.self] = newValue }
        }
}

extension TrafficLight.GreenLightColor {
    var color: UIColor {
        switch self {
        case .green:
            return .green
        case .turquoise:
            return UIColor(red: 0.25, green: 0.88, blue: 0.82, alpha: 1.00)
        }
    }
}


let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

var currentLight: TrafficLight = TrafficLight()
currentLight.preferredGreenLightColor = .turquoise

currentLight.onStateChanged = { state in
    var color = UIColor.black
    switch state {
    case .caution:
        color = .yellow
    case .proceed:
        color = currentLight.preferredGreenLightColor.color
    case .stop:
        color = .red
    }
    view.backgroundColor = color
}

currentLight.start()


public protocol TrafficLightOption {
    associatedtype Value
    
    /// 默认的选项值
    static var defaultValue: Value { get }
}

//: [Next](@next)
