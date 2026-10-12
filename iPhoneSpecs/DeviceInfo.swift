import UIKit
import Darwin

struct DeviceInfo: Identifiable {
    let id = UUID()
    let label: String
    let value: String
}

enum DeviceSnapshot {
    static func items() -> [DeviceInfo] {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        let process = ProcessInfo.processInfo
        let screen = UIScreen.main
        let bounds = screen.nativeBounds
        let battery = device.batteryLevel
        let capacity = fileSystemSize(at: NSHomeDirectory())
        let uptime = process.systemUptime

        return [
            .init(label: "Device", value: device.name),
            .init(label: "Model", value: modelIdentifier()),
            .init(label: "System", value: "\(device.systemName) \(device.systemVersion)"),
            .init(label: "Screen", value: "\(Int(bounds.width)) × \(Int(bounds.height)) pixels"),
            .init(label: "Scale", value: "\(String(format: "%.1f", screen.nativeScale))×"),
            .init(label: "Processor cores", value: "\(process.processorCount)"),
            .init(label: "Memory", value: ByteCountFormatter.string(fromByteCount: Int64(process.physicalMemory), countStyle: .memory)),
            .init(label: "Storage", value: capacity),
            .init(label: "Battery", value: battery >= 0 ? "\(Int(battery * 100))%" : "Unavailable"),
            .init(label: "Low Power Mode", value: process.isLowPowerModeEnabled ? "On" : "Off"),
            .init(label: "Uptime", value: duration(uptime))
        ]
    }

    private static func modelIdentifier() -> String {
        var info = utsname()
        uname(&info)
        return withUnsafePointer(to: &info.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { String(cString: $0) }
        }
    }

    private static func fileSystemSize(at path: String) -> String {
        guard let attributes = try? FileManager.default.attributesOfFileSystem(forPath: path),
              let total = attributes[.systemSize] as? NSNumber,
              let free = attributes[.systemFreeSize] as? NSNumber else { return "Unavailable" }
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return "\(formatter.string(fromByteCount: total.int64Value)) total • \(formatter.string(fromByteCount: free.int64Value)) free"
    }

    private static func duration(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: seconds) ?? "Unavailable"
    }
}
