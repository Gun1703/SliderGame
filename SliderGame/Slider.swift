//
//  Slider.swift
//  SliderGame
//
//  Created by Gleb Gunin on 02.05.2023.
//

import SwiftUI

struct CustomSlider: UIViewRepresentable {
    
    @Binding var value: Double
    @Binding var alpha: Double
    
    
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
         )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = UIColor(
            red: 255 / 255,
            green: 1 / 255,
            blue: 1 / 255,
            alpha: CGFloat(alpha / 100)
        )
        uiView.value = Float(self.value)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value, alpha: $alpha)
    }
}


extension CustomSlider {
    final class Coordinator: NSObject {
        var value: Binding<Double>
        var alpha: Binding<Double>
        
        init(value: Binding<Double>, alpha: Binding<Double>) {
            self.value = value
            self.alpha = alpha
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
}
