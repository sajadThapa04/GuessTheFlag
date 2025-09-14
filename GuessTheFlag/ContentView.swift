//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sajad Thapa on 9/14/25.
//

import SwiftUI

struct ContentView: View {
   @State private var countries = ["Estonia","France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK" , "Ukraine" , "US"]
   @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var scoreCount: Int = 0
    @State private var showingScore:Bool = false
    @State private var scoreTitle: String = ""
    var body: some View {
        ZStack {
       
            RadialGradient(stops: [
                .init(color: Color(red:0.1 , green:0.2 , blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.34) , location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack (spacing:30){
                    VStack {
                        Text("Tap the flag")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                            .fontWeight(.bold)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .fontWeight(.bold)
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 2)
                                .padding(10)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(scoreCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue" , action: askQuestion)
        } message: {
            Text("your score is \(scoreCount)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
        }else {
            scoreTitle = "Wrong"
            if scoreCount > 0 {
                scoreCount -= 1

            }
            
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        
    }
}


#Preview {
    ContentView()
}
