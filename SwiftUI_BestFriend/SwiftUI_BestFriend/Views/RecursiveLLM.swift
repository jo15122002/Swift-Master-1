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
    
    var contextPrompts:[String] = [
        "Le modèle est un chef expérimenté qui connaît une grande variété de recettes de cuisine. Il est capable d'innover avec les ingrédients disponibles et de proposer des recettes uniques et réalisables. Le modèle prend en compte les combinaisons d'ingrédients et adapte les recettes en fonction de ce qui est donné comme ingrédients",
        "Le modèle est compétent en nutrition et comprend comment calculer la teneur en macronutriments des aliments. Il analyse les ingrédients d'une recette et est capable de fournir une estimation précise de la teneur en protéines.",
        "Le modèle possède des connaissances approfondies en diététique sportive et comprend les besoins nutritionnels d'un homme adulte pratiquant une activité physique. Il est capable d'évaluer si une quantité donnée de protéines est suffisante en se basant sur des directives nutritionnelles standard."
    ]
    
    var body: some View {
        VStack{
            TextField("Prompt de départ", text: $startPrompt)
                .onSubmit {
                    var prompt = prompts[selectedPrompt].replacingOccurrences(of: "#PROMPT#", with: startPrompt)
                    model.sendChat(message: prompt, image: UIImage(), contextPrompt: contextPrompts[selectedPrompt])
                    self.selectedPrompt += 1
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
                if(self.selectedPrompt < self.prompts.count){
                    var prompt = prompts[selectedPrompt].replacingOccurrences(of: "#PROMPT#", with: receveivedText)
                    model.sendChat(message: prompt, image: UIImage(), contextPrompt: contextPrompts[selectedPrompt])
                    self.selectedPrompt += 1
                }
            }
        })
    }
}

#Preview {
    RecursiveLLM()
}
