import HappyColors
import UIKit

public enum HappyButtonType: String {
    case confirm
    case cancel
    case normal
    case normalTransluscent
}

var hapticButtons = [String: String]()

public extension UIButton {
    
    func setStyling(_ style: HappyButtonType) {
        titleLabel?.font = .systemFont(ofSize: 19, weight: .medium)
        setTitleColor(.flatWhite, for: .normal)
        setTitleColor(.flatWhiteDark, for: .highlighted)
        switch style {
        case .normal:
            backgroundColor = .flatBlue
        case .cancel:
            backgroundColor = .reject
        case .confirm:
            backgroundColor = .confirm
        case .normalTransluscent:
            backgroundColor = .clear
            layer.borderColor = UIColor.flatBlue.cgColor
            layer.borderWidth = 2.0
            setTitleColor(.flatBlue, for: .normal)
            setTitleColor(.flatBlueDark, for: .highlighted)
        }
        
        layer.cornerRadius = 12
        let key = "\(Unmanaged.passUnretained(self).toOpaque())"
        hapticButtons[key] = style.rawValue
        addTarget(self, action: #selector(hb_haptic_tapped), for: .touchUpInside)
    }
    
    func setStyling(_ style: HappyButtonType,
                    text: String) {
        setTitle(text, for: .normal)
        setStyling(style)
    }
    
    @objc private func hb_haptic_tapped() {
        let key = "\(Unmanaged.passUnretained(self).toOpaque())"
        guard let style = hapticButtons[key] else {
            return
        }
        if style == "confirm" {
        
            let generator = UINotificationFeedbackGenerator()
                       generator.notificationOccurred(.success)

        } else if style == "cancel"  {
                      let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()

        } else {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}

