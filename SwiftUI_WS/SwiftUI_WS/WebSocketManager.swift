//
//  WebSocketManager.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import Foundation
import NWWebSocket
import Network

class WebSocketManager : WebSocketConnectionDelegate{
    func webSocketDidConnect(connection: WebSocketConnection) {
        print("connected")
        self.connectedCallback()
    }
    
    func webSocketDidDisconnect(connection: WebSocketConnection, closeCode: NWProtocolWebSocket.CloseCode, reason: Data?) {
        print("disconnected")
        self.disconnectedCallback()
    }
    
    func webSocketViabilityDidChange(connection: WebSocketConnection, isViable: Bool) {
        print("viability changed")
    }
    
    func webSocketDidAttemptBetterPathMigration(result: Result<WebSocketConnection, NWError>) {
        print("attempt better path migration")
    }
    
    func webSocketDidReceiveError(connection: WebSocketConnection, error: NWError) {
        print("error received : " + error.debugDescription)
    }
    
    func webSocketDidReceivePong(connection: WebSocketConnection) {
        print("pong")
    }
    
    func webSocketDidReceiveMessage(connection: WebSocketConnection, string: String) {
        print("message: " + string)
    }
    
    func webSocketDidReceiveMessage(connection: WebSocketConnection, data: Data) {
        print("received data message")
    }
    
    
    static let instance = WebSocketManager()
    
    private var socket:NWWebSocket?
    
    private var connectedCallback:()->() = {}
    private var disconnectedCallback:()->() = {}
    
    func connectToUrl(url:String, intervalPing:Bool = false, callback:@escaping (()->()) = {}){
        if let socketURL = URL(string: url){
            self.socket = NWWebSocket(url: socketURL)
            self.socket?.delegate = self
            self.socket?.connect()
            
            self.connectedCallback = callback
            
            if(intervalPing){
                socket?.ping(interval: 30.0)
            }
        }
    }
    
    func disconnect(callback:@escaping (()->()) = {}){
        self.disconnectedCallback = callback
        self.socket?.disconnect()
    }
    
    func sendMessage(message:String, callback:@escaping (()->()) = {}){
        socket?.send(string: message)
        callback()
    }
    
    func sendData(data:Data, callback:@escaping (()->()) = {}){
        self.socket?.send(data: data)
        callback()
    }
    
}
