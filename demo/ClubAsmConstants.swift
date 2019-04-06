//
//  ClubAsmConstants.swift
//  demo
//
//  Created by Johan Halin on 24/03/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import Foundation

struct ClubAsmConstants {
    static let bpm = 140.0
    static let barLength = (120.0 / ClubAsmConstants.bpm) * 2.0
    static let tickLength = ClubAsmConstants.barLength / 16.0
}

struct ClubAsmPositions {
    static let start = 0
    static let startEnd = 3
    static let beatNoBasslineStart = 4
    static let beatNoBasslineEnd = 11
    static let beatBasslineStart = 12
    static let beatBasslineFill = 20
    static let raveStart = 28
    static let raveChords = 36
    static let raveMelody = 44
    static let raveEnd = 51
    static let beatBassline2Start = 52
    static let beatBassline2Fill = 59
    static let beatBassline2NoKick = 68
    static let end = 69
}
