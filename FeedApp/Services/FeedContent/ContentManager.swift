//
//  ContentManager.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/23/21.
//

import Foundation

enum FeedType {
    case imageContentType
    case trackType
}

struct NewsContentManager {
    let authorNames = ["PnB Rock", "Rich The Kid", " Yellow Claw", "KYLE", "Sir Walter Scott", "Grits",
                       "Frank Sinatra", "Jerry Di", "Yung Gravy", "Fredo Bang", "Rob Base", "Teddy Pendergrass",
                       "Serj Tankian", "BLAKE FADES", " Missy Elliott", "Lil Nas X", "Morcheeba", " Rag'n'Bone Man",
                       "Capleton", "illiam Cooper", "Curtis Mayfield", " Flo Rida", "Hopsin",  "B2K"]
    

    
    func getAuthorName() -> String {
        return authorNames.randomElement() ?? ""
    }
    
    func getFeedType() -> FeedType {
        let randomValue = Int.random(in: 1...10)
        let feedType: FeedType = randomValue > 8 ? .trackType : .imageContentType
        return feedType
    }
}
