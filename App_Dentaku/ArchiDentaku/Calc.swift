//
//  Calc.swift
//  ArchiDentaku
//
//  Created by tsune on 2022/11/21.
//

import SwiftUI

//ObservedObjectでここにまとめて記述
class Calc: ObservableObject {
    @Published var buttonColor : [Color] = [Color.white, Color.white, Color.white, Color.white]
    @Published var showAlert = false
    @Published var calcProcess = ""
    @Published var dotUse = false
    @Published var enzanTag = false
    @Published var output: Double = 0.0
    @Published var roundOutput: Double = 0.0
}
