//
//  NetworkMonitor.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Network

public final class NetworkMonitor {
    
    public static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    public enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
        }
        self.monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        self.monitor.cancel()
    }
    
    public func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            self.connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self.connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            self.connectionType = .ethernet
        } else {
            self.connectionType = .unknown
        }
    }
}
