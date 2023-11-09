import UIKit

var monInt = 3 //On stocke une valeur dans une variable, c'est une information statique
monInt = 5

var monCallback = { // On stocke un code executable dans une variable
    print("toto")
}

monCallback() // on execute le code présent dans 'monCallback'

var monCallbackAvecParam : (Int)->() = { p1 in
        print("Depuis ma callback \(p1)")
}

monCallbackAvecParam(4) //print 4

func maFonctionQuiPrendsUNInt(p1:Int){
    print("Depuis ma fonction \(p1)")
}

maFonctionQuiPrendsUNInt(p1: 4)
monCallbackAvecParam = maFonctionQuiPrendsUNInt

class Manager {
    
    func connect(){
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in //On simule une connection qui prends du temps
            print("Connected")
        }
    }
    
    func sendData(){
        print("send data")
    }
}

var manager = Manager()
manager.connect() //connection
manager.sendData() //lancé direct après même si la connection est pas finie


class ManagerWithCallback {
    
    var callback = {}
    
    func connect(callback:@escaping ()->()){
        self.callback = callback
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in //On simule une connection qui prends du temps
            print("Connected")
            self.callback()
        }
    }
    
    func sendData(){
        print("send data")
    }
}

var managerWithCallback = ManagerWithCallback()
managerWithCallback.connect {
    managerWithCallback.sendData()
}

RunLoop.main.run()
