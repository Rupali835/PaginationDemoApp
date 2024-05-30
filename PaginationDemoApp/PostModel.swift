//
//  PostModel.swift
//  PaginationDemoApp
//
//  Created by Watch Your Health on 30/05/24.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
