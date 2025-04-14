//
//  LoginData.swift
//  Keio-KLMS
//
//  Created by 小谷理人 on 2025/04/14.
//

import SwiftUI

class loginData : ObservableObject{
    @AppStorage("keioid") private var keioid: String = ""
    @AppStorage("password") private var password: String = ""
    
    var credentials: (String, String) {
        (keioid, password)
    }
}
