//
//  ContentView.swift
//  SliderGame
//
//  Created by Gleb Gunin on 02.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var currentValue = Double.random(in: 0...100)
    @State private var showAlert = false
    @State private var targetValue = Int.random(in: 1...100)
    @State private var alpha = 100.0
    
    
    var body: some View {
        VStack{
            Text("Подвиньте слайдер, как можно ближе к: \(targetValue)")
                .lineLimit(2)
                .padding(.bottom, 20)
            HStack{
                Text("0")
                CustomSlider(value: $currentValue, alpha:$alpha)
                .onChange(of: currentValue, perform: { value in
                    alpha = Double(computeScore())
                })
                Text("100")
            }
            .alert(isPresented: $showAlert, content: {
                .init(title: Text("Ваш результат:"),
                      message: Text("\(computeScore())"),
                      dismissButton: .default(Text("OK"))
                )
            })
            .padding(.bottom, 55)
            Button(action: {
                showAlert = true
            }, label: {
                Text("Проверь меня!")
                    .font(.title2)
            })
            .padding(.bottom, 20)
            Button(action: {
                targetValue = Int.random(in: 1...100)
                currentValue = Double.random(in: 0...100)
            }, label: {
                Text("Начать заново")
                    .font(.title2)
            })
        }
        .padding()
    }
}

extension ContentView {
    private func computeScore() -> Int {
        let difference = abs(Int(targetValue) - Int(lround(Double(currentValue))))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
