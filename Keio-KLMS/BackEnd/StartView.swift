//
//  StartView.swift
//  Keio-KLMS
//
//  Created by 小谷理人 on 2025/04/14.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("慶應生がK-LMSがアプリケーションになっていない、")
            Text("小さい”めんどくさい”を解決したアプリです。")
            Spacer()
            
            Text("ログインデータ等は携帯上に保存されているので安心してください").frame(alignment: .center).font(.caption)
            Spacer()
        }
    }
}

#Preview {
    StartView()
}
