//
//  NetworkManager.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import Foundation
import Network

@MainActor
final class NetworkManager: ObservableObject {
    // MARK: - PROPERTIES
    static let shared: NetworkManager = .init()
    
    private let monitor = NWPathMonitor()
    private let networkManagerQueue = DispatchQueue(label: "com.kdtechniques.IAMSAD.networkManagerQueue")
    
    private var didAvoidFirst: Bool = false
    private var tempConnectionStatus: ConnectionStatus = .noConnection
    
    @Published private(set) var connectionStatus: ConnectionStatus = .noConnection {
        didSet {
            if tempConnectionStatus == .connected && connectionStatus == .noConnection {
                handleNoConnectionStatus()
                tempConnectionStatus = .noConnection
            } else if tempConnectionStatus == .noConnection && connectionStatus == .connected {
                handleConnectedStatus()
                tempConnectionStatus = .connected
            }
        }
    }
    
    enum ConnectionStatus {
        case connected
        case noConnection
    }
    
    // MARK: - INITIALIZER
    private init() { startNetworkMonitor() }
    
    // MARK: - FUNCTIONS
    
    // MARK: - startNetworkMonitor
    private func startNetworkMonitor() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async { self.connectionStatus = .connected }
            } else {
                DispatchQueue.main.async { self.connectionStatus = .noConnection }
            }
        }
        
        monitor.start(queue: networkManagerQueue)
    }
    
    // MARK: - handleConnectedStatus
    private func handleConnectedStatus() {
        print("Connected to a Network. 🛜🛜🛜")
        
        //        if self.didAvoidFirst {
        //            BottomPopupViewModel.shared.bottomPopupItem = .init(
        //                systemImage: "wifi",
        //                type: .system,
        //                text: "Your Internet connection has been restored.",
        //                iconColor: .green
        //            )
        //        } else {
        //            self.didAvoidFirst = true
        //        }
    }
    
    // MARK: - handleNoConnectionStatus
    private func handleNoConnectionStatus() {
        print("No Network Connection. 😕😕😕")
        
        //        if self.didAvoidFirst {
        //            BottomPopupViewModel.shared.bottomPopupItem = .init(
        //                systemImage: "wifi.slash",
        //                type: .system,
        //                text: "You are currently offline.",
        //                iconColor: .secondary
        //            )
        //        } else {
        //            self.didAvoidFirst = true
        //        }
    }
}
