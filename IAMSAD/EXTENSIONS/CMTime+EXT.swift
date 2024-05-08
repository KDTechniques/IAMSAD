//
//  CMTime+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-09.
//

import CoreMedia

extension CMTime {
    // MARK: - asString
    func asString() -> String {
        let totalSeconds = CMTimeGetSeconds(self)
        let hours = Int(totalSeconds / 3600)
        let minutes = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02i:%02i", minutes, seconds)
        } else {
            return String(format: "0:%02i", seconds)
        }
    }
}
