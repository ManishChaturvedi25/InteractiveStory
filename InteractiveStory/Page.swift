//
//  Page.swift
//  InteractiveStory
//
//  Created by ctsuser1 on 4/13/17.
//  Copyright © 2017 ctsuser1. All rights reserved.
//

import Foundation

class Page
{
    
    let story:Story
    
    typealias Choice  = (title:String, page: Page)
    var firstChoice: Choice?
    var secondChoice: Choice?

    init(story:Story) {
        self.story = story
    }
    
}

