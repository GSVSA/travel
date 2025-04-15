import SwiftUI

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkmark: CheckboxToggleStyle { CheckboxToggleStyle() }
}

extension ToggleStyle where Self == RadioButtonToggleStyle {
    static var radioButton: RadioButtonToggleStyle { RadioButtonToggleStyle() }
}
