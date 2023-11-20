//
//  RecursiveLLM.swift
//  SwiftUI_Merveille
//
//  Created by digital on 20/11/2023.
//

import SwiftUI

struct RecursiveLLM: View {
    
    var preprompt = ""
    @State var startPrompt:String = ""
    
    @ObservedObject var model = ChatObservable()
    
    @State var selectedPrompt = 0
    
    var prompts:[String] = [
        "A partir de cette liste d'ingrédients, génère une recette de cuisine: #PROMPT#",
        "Donne moi la quantité de protéines (en gramme, sous la forme d'un entier) de cette recette: #PROMPT#",
        "Dis moi si #PROMPT# grammes de protéines est suffisant pour un homme adulte faisant du sport",
    ]
    
    var body: some View {
        VStack{
            TextField("Prompt de départ", text: $startPrompt)
                .onSubmit {
                    model.sendChat(message: startPrompt, image: UIImage())
                }
            ForEach(prompts, id:\.self){ prompt in
                Text(prompt).fontWeight(prompts.index(of: prompt) == self.selectedPrompt ? .bold : .medium)
                Rectangle().frame(height: 1)
            }
            Spacer()
            ForEach(model.messageList){response in
                Text(response.text!)
                Rectangle().frame(height: 1)
            }
        }.onChange(of: model.messageList, perform: { value in
            if let lastMessage = value.last,
               let receveivedText = lastMessage.text{
                var prompt = prompts[selectedPrompt].replacingOccurrences(of: "#PROMPT#", with: receveivedText)
                model.sendChat(message: prompt, image: UIImage())
                self.selectedPrompt += 1
            }
        })
    }
}

#Preview {
    RecursiveLLM()
}
