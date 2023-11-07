import UIKit

var greeting = "Hello, playground"
print(greeting)

class A {
    var b:Int = 0
}

struct B {
    var a:Int = 0 {
        didSet{
            print("A is modified")
        }
    }
    
    
    var c:Float = 1
    
}

let a = A() // Adresse constante
// a = A() Interdit d'écrire une nouvelle adresse
a.b = 2 // On modifie la propriété à l'adresse
var b = B()  // Objet constant
// b.a = 3 // Intedit d'écrire/modifier l'objet
func modifClass(p1:A){
    // p1 = A() // Interdit d'écrire une nouvelle adresse
    p1.b = 42
}
modifClass(p1: a)
print(a.b)

func Slider(p1: inout B){
    p1.a = 42
}

func SliderZ(p1: inout B){
    p1.c = 0.3
}



Slider(p1: &b)
SliderZ(p1: &b)
print(b.a)
print(b.c)
