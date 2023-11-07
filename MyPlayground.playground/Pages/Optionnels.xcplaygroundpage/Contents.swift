//: [Previous](@previous)

import Foundation

var nonInt:Int? //Int optionnel à nil par défaut
nonInt = 4 //On met 4 dans l'enveloppe Optionnel(Int)

print(nonInt)

if let monIntSansEnveloppe = nonInt{ //on prends le contenu de l'enveloppe et on le met dans la var de gauche si il y a un contenu
    print(monIntSansEnveloppe)
}

//: [Next](@next)
