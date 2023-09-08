//
//  NetworkMonitorManager.swift
//  FilmTestTask
//
//  Created by APPLE on 07.09.2023.
//

import Foundation
import Network

protocol NetworkMonitorProtocol {
    
    func startMonitoring()
    func stopMonitoring()
}

final class NetworkMonitor: NetworkMonitorProtocol {
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global(qos: .userInteractive)
    
    public private(set) var isConnected: Bool = false
    
    private var monitor: NWPathMonitor
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
